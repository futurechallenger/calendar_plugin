import 'calendar_plugin_platform_interface.dart';

class CalendarPlugin {
  Future<String?> getPlatformVersion() {
    return CalendarPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> addEventToCalendar(String eventName) {
    return CalendarPluginPlatform.instance.addEventToCalendar(eventName);
  }
}
