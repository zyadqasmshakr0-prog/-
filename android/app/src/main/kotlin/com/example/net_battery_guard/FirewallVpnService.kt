package com.example.net_battery_guard

import android.content.Context
import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor
import java.util.ArrayList
import java.util.HashSet

class FirewallVpnService : VpnService() {
    companion object {
        @Volatile
        var isRunning: Boolean = false
    }

    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val action = intent?.action
        val prefs = getSharedPreferences("vpn_state_prefs", Context.MODE_PRIVATE)

        if (action == "STOP_VPN") {
            isRunning = false
            prefs.edit().putBoolean("vpn_active", false).apply()
            stopFirewall()
            stopSelf()
            return START_NOT_STICKY
        }

        val blockedApps = intent?.getStringArrayListExtra("blockedApps") ?: ArrayList<String>()
        applyFirewallRules(blockedApps)
        isRunning = true
        prefs.edit().putBoolean("vpn_active", true).apply()
        return START_STICKY
    }

    private fun applyFirewallRules(blockedApps: ArrayList<String>) {
        try {
            vpnInterface?.close()
            vpnInterface = null

            val builder = Builder()
                .setSession("قاطع الانترنت مجانا")
                .setMtu(1500)
                .addAddress("10.1.10.1", 32)
                .addRoute("0.0.0.0", 0)
                .addDnsServer("8.8.8.8")
                .addDnsServer("1.1.1.1")

            val pm = packageManager
            val allPackages = pm.getInstalledApplications(0)
            val blockedSet = HashSet<String>(blockedApps)

            // الحزم الأساسية التي تحتاجها تطبيقات جوجل و Gemini والنظام لكي لا ينقطع عنها الإنترنت إذا سُمح لها
            val essentialCorePackages = HashSet<String>()
            essentialCorePackages.add(packageName)
            essentialCorePackages.add("com.google.android.gms") // خدمات جوجل بلاي الأساسية
            essentialCorePackages.add("com.google.android.gsf") // إطار خدمات جوجل
            essentialCorePackages.add("com.google.android.webview") // محرك الويب الداخلي
            essentialCorePackages.add("com.android.webview")
            essentialCorePackages.add("com.android.providers.downloads")
            essentialCorePackages.add("com.google.android.networkstack")
            essentialCorePackages.add("com.android.networkstack")
            essentialCorePackages.add("com.google.android.captiveportallogin")

            // تطبيقات جوجل و Gemini الذكية: إذا لم يحظرها المستخدم صراحةً، نضمن مرورها مع خدماتها
            for (app in allPackages) {
                val pkg = app.packageName
                val isAllowedByUser = !blockedSet.contains(pkg)
                val isEssentialCore = essentialCorePackages.contains(pkg)

                if (isAllowedByUser || isEssentialCore) {
                    try {
                        builder.addDisallowedApplication(pkg)
                    } catch (_: Exception) {}
                }
            }

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
        isRunning = false
        stopFirewall()
        super.onDestroy()
    }
}
