package com.example.net_battery_guard

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor
import java.util.ArrayList

class FirewallVpnService : VpnService() {
    private var vpnInterface: ParcelFileDescriptor? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val action = intent?.action
        if (action == "STOP_VPN") {
            stopFirewall()
            stopSelf()
            return START_NOT_STICKY
        }

        val blockedApps = intent?.getStringArrayListExtra("blockedApps") ?: ArrayList<String>()
        applyFirewallRules(blockedApps)
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
                .addDnsServer("1.1.1.1")
                .addDnsServer("8.8.8.8")

            val pm = packageManager
            val allPackages = pm.getInstalledApplications(0)
            val blockedSet = blockedApps.toHashSet()

            for (app in allPackages) {
                val pkg = app.packageName
                if (!blockedSet.contains(pkg)) {
                    try {
                        builder.addDisallowedApplication(pkg)
                    } catch (_: Exception) {}
                }
            }

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
