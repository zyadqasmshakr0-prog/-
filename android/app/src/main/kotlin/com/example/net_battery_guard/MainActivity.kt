package com.example.net_battery_guard

import android.app.Activity
import android.app.AppOpsManager
import android.app.usage.NetworkStats
import android.app.usage.NetworkStatsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.NetworkCapabilities
import android.net.TrafficStats
import android.net.Uri
import android.net.VpnService
import android.os.BatteryManager
import android.os.Build
import android.os.Process
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import java.util.ArrayList
import java.util.HashMap

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.free.netblocker/vpn"
    private val VPN_REQUEST_CODE = 777
    private var pendingBlockedApps: ArrayList<String>? = null
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledApps" -> {
                    Thread {
                        val apps = fetchAllInstalledApps()
                        runOnUiThread { result.success(apps) }
                    }.start()
                }
                "isVpnActive" -> {
                    val prefs = getSharedPreferences("vpn_state_prefs", Context.MODE_PRIVATE)
                    val active = FirewallVpnService.isRunning || prefs.getBoolean("vpn_active", false)
                    result.success(active)
                }
                "startOrUpdateVpn" -> {
                    val rawList = call.argument<List<String>>("blockedApps")
                    val blocked = ArrayList<String>()
                    if (rawList != null) {
                        for (item in rawList) {
                            blocked.add(item)
                        }
                    }
                    startVpnWithPermission(blocked, result)
                }
                "stopVpn" -> {
                    val prefs = getSharedPreferences("vpn_state_prefs", Context.MODE_PRIVATE)
                    prefs.edit().putBoolean("vpn_active", false).apply()
                    FirewallVpnService.isRunning = false
                    val intent = Intent(this, FirewallVpnService::class.java)
                    intent.action = "STOP_VPN"
                    startService(intent)
                    result.success(true)
                }
                "getLiveSystemStats" -> {
                    Thread {
                        val stats = fetchLiveSystemStats()
                        runOnUiThread { result.success(stats) }
                    }.start()
                }
                "hasUsagePermission" -> {
                    result.success(checkUsagePermission())
                }
                "requestUsagePermission" -> {
                    try {
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                "openSystemBatterySummary" -> {
                    try {
                        val intent = Intent(Intent.ACTION_POWER_USAGE_SUMMARY)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.success(false)
                    }
                }
                "sendFeedbackToGoogleAccount" -> {
                    val subject = call.argument<String>("subject") ?: "تقييم ومقترح - قاطع الانترنت مجانا"
                    val body = call.argument<String>("body") ?: ""
                    val sent = sendEmailToDeveloper("zyadqasmshakr0@gmail.com", subject, body)
                    result.success(sent)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun sendEmailToDeveloper(email: String, subject: String, body: String): Boolean {
        return try {
            val uri = Uri.parse("mailto:$email?subject=" + Uri.encode(subject) + "&body=" + Uri.encode(body))
            val intent = Intent(Intent.ACTION_SENDTO, uri)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            true
        } catch (e: Exception) {
            try {
                val fallback = Intent(Intent.ACTION_SEND)
                fallback.type = "message/rfc822"
                fallback.putExtra(Intent.EXTRA_EMAIL, arrayOf(email))
                fallback.putExtra(Intent.EXTRA_SUBJECT, subject)
                fallback.putExtra(Intent.EXTRA_TEXT, body)
                fallback.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(Intent.createChooser(fallback, "Send via Google Account"))
                true
            } catch (_: Exception) {
                false
            }
        }
    }

    private fun checkUsagePermission(): Boolean {
        return try {
            val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
            val mode = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                appOps.unsafeCheckOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), packageName)
            } else {
                appOps.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), packageName)
            }
            mode == AppOpsManager.MODE_ALLOWED
        } catch (e: Exception) {
            false
        }
    }

    private fun startVpnWithPermission(blockedApps: ArrayList<String>, result: MethodChannel.Result) {
        val intent = VpnService.prepare(this)
        if (intent != null) {
            pendingBlockedApps = blockedApps
            pendingResult = result
            startActivityForResult(intent, VPN_REQUEST_CODE)
        } else {
            launchFirewallService(blockedApps)
            result.success(true)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == VPN_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK && pendingBlockedApps != null) {
                launchFirewallService(pendingBlockedApps!!)
                pendingResult?.success(true)
            } else {
                pendingResult?.success(false)
            }
            pendingBlockedApps = null
            pendingResult = null
        }
    }

    private fun launchFirewallService(blockedApps: ArrayList<String>) {
        val prefs = getSharedPreferences("vpn_state_prefs", Context.MODE_PRIVATE)
        prefs.edit().putBoolean("vpn_active", true).apply()
        FirewallVpnService.isRunning = true
        val intent = Intent(this, FirewallVpnService::class.java)
        intent.action = "START_OR_UPDATE"
        intent.putStringArrayListExtra("blockedApps", blockedApps)
        startService(intent)
    }

    private fun getUidBytesMapFromNetworkStats(): HashMap<Int, Long> {
        val uidBytesMap = HashMap<Int, Long>()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && checkUsagePermission()) {
            try {
                val netStatsManager = getSystemService(Context.NETWORK_STATS_SERVICE) as NetworkStatsManager
                val now = System.currentTimeMillis()
                val startOfMonth = now - (1000L * 60L * 60L * 24L * 30L)

                val wifiStats = netStatsManager.querySummary(NetworkCapabilities.TRANSPORT_WIFI, null, startOfMonth, now)
                val bucket = NetworkStats.Bucket()
                while (wifiStats.hasNextBucket()) {
                    wifiStats.getNextBucket(bucket)
                    val uid = bucket.uid
                    val prev = uidBytesMap[uid] ?: 0L
                    uidBytesMap[uid] = prev + bucket.rxBytes + bucket.txBytes
                }
                wifiStats.close()

                val mobileStats = netStatsManager.querySummary(NetworkCapabilities.TRANSPORT_CELLULAR, null, startOfMonth, now)
                while (mobileStats.hasNextBucket()) {
                    mobileStats.getNextBucket(bucket)
                    val uid = bucket.uid
                    val prev = uidBytesMap[uid] ?: 0L
                    uidBytesMap[uid] = prev + bucket.rxBytes + bucket.txBytes
                }
                mobileStats.close()
            } catch (_: Exception) {}
        }
        return uidBytesMap
    }

    private fun getAppBytes(uid: Int, netStatsMap: HashMap<Int, Long>): Long {
        val rx = TrafficStats.getUidRxBytes(uid)
        val tx = TrafficStats.getUidTxBytes(uid)
        val trafficTotal = (if (rx > 0) rx else 0L) + (if (tx > 0) tx else 0L)
        val netStatsTotal = netStatsMap[uid] ?: 0L
        return if (netStatsTotal > trafficTotal) netStatsTotal else trafficTotal
    }

    private fun fetchAllInstalledApps(): ArrayList<Any> {
        val pm = packageManager
        val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
        val appList = ArrayList<Any>()
        val netStatsMap = getUidBytesMapFromNetworkStats()

        for (appInfo in packages) {
            val pkg = appInfo.packageName
            if (pkg == packageName) continue

            val label = pm.getApplicationLabel(appInfo).toString()
            val isSystem = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
            val uid = appInfo.uid
            val totalBytes = getAppBytes(uid, netStatsMap)

            val item = HashMap<String, Any>()
            item["name"] = label
            item["packageName"] = pkg
            item["isSystem"] = isSystem
            item["uid"] = uid
            item["totalBytes"] = totalBytes
            item["icon"] = drawableToByteArray(pm.getApplicationIcon(appInfo))

            appList.add(item)
        }
        return appList
    }

    private fun fetchLiveSystemStats(): HashMap<String, Any> {
        val response = HashMap<String, Any>()
        val pm = packageManager
        val packages = pm.getInstalledApplications(0)
        val netStatsMap = getUidBytesMapFromNetworkStats()

        val trafficMap = HashMap<String, Long>()
        for (app in packages) {
            val bytes = getAppBytes(app.uid, netStatsMap)
            trafficMap[app.packageName] = bytes
        }
        val totalDeviceRx = TrafficStats.getTotalRxBytes().coerceAtLeast(0L)
        val totalDeviceTx = TrafficStats.getTotalTxBytes().coerceAtLeast(0L)
        response["deviceTotalBytes"] = totalDeviceRx + totalDeviceTx
        response["appTraffic"] = trafficMap

        val prefs = getSharedPreferences("vpn_state_prefs", Context.MODE_PRIVATE)
        response["isVpnActive"] = FirewallVpnService.isRunning || prefs.getBoolean("vpn_active", false)

        val batteryIntent = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val bm = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        val level = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        val currentNowMicro = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_NOW)
        val status = batteryIntent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        val isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL
        val tempTenths = batteryIntent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 300) ?: 300
        val voltageMv = batteryIntent?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, 3850) ?: 3850

        response["batteryLevel"] = if (level > 0) level else 85
        response["isCharging"] = isCharging
        response["temperatureC"] = tempTenths / 10.0
        response["voltageMv"] = voltageMv
        response["currentMa"] = kotlin.math.abs(currentNowMicro / 1000)

        val usageMap = HashMap<String, Long>()
        if (checkUsagePermission()) {
            try {
                val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
                val now = System.currentTimeMillis()
                val start = now - (1000L * 60L * 60L * 24L)
                val statsList = usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, start, now)
                if (statsList != null) {
                    for (stat in statsList) {
                        val fgTime = stat.totalTimeInForeground
                        if (fgTime > 0) {
                            val prev = usageMap[stat.packageName] ?: 0L
                            usageMap[stat.packageName] = prev + fgTime
                        }
                    }
                }
            } catch (_: Exception) {}
        }
        response["appUsageMs"] = usageMap
        response["hasUsagePermission"] = checkUsagePermission()

        return response
    }

    private fun drawableToByteArray(drawable: Drawable): ByteArray {
        return try {
            val bitmap = if (drawable is BitmapDrawable && drawable.bitmap != null) {
                Bitmap.createScaledBitmap(drawable.bitmap, 64, 64, true)
            } else {
                val bmp = Bitmap.createBitmap(64, 64, Bitmap.Config.ARGB_8888)
                val canvas = Canvas(bmp)
                drawable.setBounds(0, 0, canvas.width, canvas.height)
                drawable.draw(canvas)
                bmp
            }
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 80, stream)
            stream.toByteArray()
        } catch (e: Exception) {
            ByteArray(0)
        }
    }
}
