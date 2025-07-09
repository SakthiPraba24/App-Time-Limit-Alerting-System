package com.example.pause

import android.app.admin.DevicePolicyManager
import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent

class MidnightResetReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        val dpm = context.getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        val admin = ComponentName(context, MyDeviceAdminReceiver::class.java)
        dpm.setUninstallBlocked(admin, context.packageName, false)
    }
}
