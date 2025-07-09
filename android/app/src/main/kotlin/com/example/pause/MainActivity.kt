package com.example.pause

import android.os.Bundle
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Intent
import java.util.Calendar


class MainActivity : FlutterActivity() {
    private val CHANNEL = "app.usage/limits"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "updateLimits" -> {
                    val blocked = call.arguments as? List<Map<String, Any>>
                    val blockedPackages = blocked?.mapNotNull { it["package"] as? String } ?: emptyList()
                    AppBlockerService.instance?.updateBlockedApps(blockedPackages)
                    result.success(null)
                }
                "getAccurateUsage" -> {
                    val from = call.argument<Long>("from") ?: 0
                    val to = call.argument<Long>("to") ?: System.currentTimeMillis()
                    val usage = getForegroundUsage(this, from, to)
                    result.success(usage)
                }
                else -> result.notImplemented()
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "device.owner/admin").setMethodCallHandler { call, result ->
        when (call.method) {
            "blockUninstall" -> {
                val block = call.argument<Boolean>("block") ?: false
                blockUninstall(block)
                if (block) scheduleMidnightReset()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

}

private fun getForegroundUsage(context: Context, fromTime: Long, toTime: Long): Map<String, Long> {
    val usageStatsManager = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
    val usageEvents = usageStatsManager.queryEvents(fromTime, toTime)
    val usageMap = mutableMapOf<String, Long>()

    var currentPackage: String? = null
    var lastTimestamp: Long = 0

    val event = UsageEvents.Event()
    while (usageEvents.hasNextEvent()) {
        usageEvents.getNextEvent(event)
        val pkg = event.packageName
        when (event.eventType) {
            UsageEvents.Event.MOVE_TO_FOREGROUND -> {
                currentPackage = pkg
                lastTimestamp = event.timeStamp
            }
            UsageEvents.Event.MOVE_TO_BACKGROUND -> {
                if (!pkg.isNullOrEmpty() && currentPackage == pkg && lastTimestamp > 0) {
                    val duration = event.timeStamp - lastTimestamp
                    usageMap[pkg] = usageMap.getOrDefault(pkg, 0L) + duration
                    lastTimestamp = 0
                }
            }
        }
    }
    return usageMap
}
private fun blockUninstall(block: Boolean) {
    val dpm = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
    val admin = ComponentName(this, MyDeviceAdminReceiver::class.java)
    dpm.setUninstallBlocked(admin, packageName, block)
}

private fun scheduleMidnightReset() {
    val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
    val intent = Intent(this, MidnightResetReceiver::class.java)
    val pendingIntent = PendingIntent.getBroadcast(this, 0, intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)

    val calendar = Calendar.getInstance().apply {
        set(Calendar.HOUR_OF_DAY, 0)
        set(Calendar.MINUTE, 0)
        set(Calendar.SECOND, 0)
        set(Calendar.MILLISECOND, 0)
        add(Calendar.DAY_OF_MONTH, 1)
    }

    alarmManager.setExact(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
}

}
