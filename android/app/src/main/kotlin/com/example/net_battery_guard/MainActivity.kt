package com.example.net_battery_guard

import android.app.Activity
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.TrafficStats
import android.net.VpnService
import android.os.ParcelFileDescriptor
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

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
                "startOrUpdateVpn" -> {
                    val blocked = call.argument<List<String>>("blockedApps") ?: listOf()
                    startVpnWithPermission(ArrayList(blocked), result)
                }
                "stopVpn" -> {
                    val intent = Intent(this, FirewallVpnService::class.java)
                    intent.action = "STOP_VPN"
                    startService(intent)
                    result.success(true)
                }
                "getLiveTraffic" -> {
                    val trafficMap = fetchLiveTrafficMap()
                    result.success(trafficMap)
                }
                else -> result.notImplemented()
            }
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
        val intent = Intent(this, FirewallVpnService::class.java)
        intent.action = "START_OR_UPDATE"
        intent.putStringArrayListExtra("blockedApps", blockedApps)
        startService(intent)
    }

    private fun fetchAllInstalledApps(): List> {
        val pm = packageManager
        val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
        val appList = mutableListOf>()

        for (appInfo in packages) {
            // جلب كل شيء حرفياً في الجهاز (التطبيقات العادية + تطبيقات النظام)
            val label = pm.getApplicationLabel(appInfo).toString()
            val pkg = appInfo.packageName
            if (pkg == packageName) continue // استثناء تطبيقنا نفسه فقط

            val isSystem = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
            val uid = appInfo.uid
            val rx = TrafficStats.getUidRxBytes(uid).coerceAtLeast(0L)
            val tx = TrafficStats.getUidTxBytes(uid).coerceAtLeast(0L)
            val totalBytes = rx + tx

            appList.add(
                mapOf(
                    "name" to label,
                    "packageName" to pkg,
                    "isSystem" to isSystem,
                    "uid" to uid,
                    "totalBytes" to totalBytes,
                    "icon" to drawableToByteArray(pm.getApplicationIcon(appInfo))
                )
            )
        }
        return appList
    }

    private fun fetchLiveTrafficMap(): Map<String, Long> {
        val pm = packageManager
        val packages = pm.getInstalledApplications(0)
        val map = mutableMapOf<String, Long>()
        for (app in packages) {
            val rx = TrafficStats.getUidRxBytes(app.uid).coerceAtLeast(0L)
            val tx = TrafficStats.getUidTxBytes(app.uid).coerceAtLeast(0L)
            map[app.packageName] = rx + tx
        }
        return map
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
