import 'calendar_plugin_platform_interface.dart';

class CalendarPlugin {
  Future<String?> getPlatformVersion() {
    return CalendarPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> addEventToCalendar(String content,
      [String? note, DateTime? start, DateTime? end]) {
    return CalendarPluginPlatform.instance
        .addEventToCalendar(content, note, start, end);
  }
}
