package com.example.calendar_plugin

import android.content.ContentValues
import android.content.Context
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.time.LocalDate
import java.util.Calendar


/** CalendarPlugin */
class CalendarPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "calendar_plugin")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "addEventToCalendar") {
            val arguments = call.arguments as HashMap<*, *>;
            val title = arguments["content"] as String;
            val note = arguments["note"] as String?;
            val start = arguments["start"] as Long?;
            val end = arguments["end"] as Long?;

            val eventUriString = "content://com.android.calendar/events"
            val eventValues = ContentValues()

            eventValues.put("calendar_id", 1) // id, We need to choose from

            eventValues.put("title", title)
            eventValues.put("description", note)

            val startDate = start ?: Calendar.getInstance().timeInMillis
            val endDate = end ?: startDate.plus(1000 * 60 * 60) // For next 1hr

            eventValues.put("dtstart", startDate)
            eventValues.put("dtend", end ?: endDate)
            eventValues.put("eventTimezone", "UTC/GMT +2:00")
            eventValues.put("hasAlarm", 1) // 0 for false, 1 for true

            val eventUri: Uri =
                this.context.contentResolver.insert(Uri.parse(eventUriString), eventValues)!!
//            val eventID = eventUri?.lastPathSegment!!.toLong()
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
