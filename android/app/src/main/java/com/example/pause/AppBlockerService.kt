package com.example.pause

import android.accessibilityservice.AccessibilityService
import android.view.accessibility.AccessibilityEvent
import android.content.Intent
import android.provider.Settings
import android.os.Handler
import android.os.Looper

class AppBlockerService : AccessibilityService() {

    private val blockedApps = mutableSetOf<String>()
    private val handler = Handler(Looper.getMainLooper())

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null || event.packageName == null) return

        val currentApp = event.packageName.toString()
        if (blockedApps.contains(currentApp)) {
            redirectToHome()
        }
    }

    override fun onInterrupt() {}

    private fun redirectToHome() {
        val homeIntent = Intent(Intent.ACTION_MAIN)
        homeIntent.addCategory(Intent.CATEGORY_HOME)
        homeIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(homeIntent)
    }

    // Called from Flutter
    fun updateBlockedApps(apps: List<String>) {
        blockedApps.clear()
        blockedApps.addAll(apps)
    }

    companion object {
        var instance: AppBlockerService? = null
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
    }

    override fun onDestroy() {
        instance = null
        super.onDestroy()
    }
}
