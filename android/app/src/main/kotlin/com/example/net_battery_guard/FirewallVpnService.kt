package com.example.net_battery_guard

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor

class FirewallVpnService : VpnService() {
    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val action = intent?.action
        if (action == "STOP_VPN") {
            stopFirewall()
            stopSelf()
            return START_NOT_STICKY
        }

        val blockedApps = intent?.getStringArrayListExtra("blockedApps") ?: arrayListOf()
        applyFirewallRules(blockedApps)
        return START_STICKY
    }

    private fun applyFirewallRules(blockedApps: ArrayList<String>) {
        try {
            // إغلاق النفق القديم لتحديث القواعد فوراً على كل ضغطة
            vpnInterface?.close()
            vpnInterface = null

            val builder = Builder()
                .setSession("قاطع الانترنت مجانا - مسرع الشبكة")
                .setMtu(1500) // تحسين حجم الحزم لتسريع استجابة الإنترنت للتطبيقات المسموحة
                .addAddress("10.1.10.1", 32)
                .addRoute("0.0.0.0", 0)
                // إضافة أسرع خوادم DNS عالمية (Cloudflare + Google) لتسريع التصفح والتحميل
                .addDnsServer("1.1.1.1")
                .addDnsServer("8.8.8.8")

            val pm = packageManager
            val allPackages = pm.getInstalledApplications(0)
            val blockedSet = blockedApps.toHashSet()

            // الفكرة العبقرية: التطبيقات المسموح لها تخرج مباشرة للإنترنت الحقيقي بأقصى سرعة
            // بينما التطبيقات التي عليها علامة (صح) تدخل نفق الحجب المحلي المقطوع (Blackhole)
            for (app in allPackages) {
                val pkg = app.packageName
                if (!blockedSet.contains(pkg)) {
                    try {
                        builder.addDisallowedApplication(pkg)
                    } catch (_: Exception) {}
                }
            }

            // دائماً نستثني تطبيقنا نفسه من الحجب
            try {
                builder.addDisallowedApplication(packageName)
            } catch (_: Exception) {}

            vpnInterface = builder.establish()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopFirewall() {
        try {
            vpnInterface?.close()
            vpnInterface = null
        } catch (_: Exception) {}
    }

    override fun onDestroy() {
        stopFirewall()
        super.onDestroy()
    }
}
