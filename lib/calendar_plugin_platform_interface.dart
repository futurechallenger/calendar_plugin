import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'calendar_plugin_method_channel.dart';

abstract class CalendarPluginPlatform extends PlatformInterface {
  /// Constructs a CalendarPluginPlatform.
  CalendarPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static CalendarPluginPlatform _instance = MethodChannelCalendarPlugin();

  /// The default instance of [CalendarPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelCalendarPlugin].
  static CalendarPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CalendarPluginPlatform] when
  /// they register themselves.
  static set instance(CalendarPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> addEventToCalendar(String content,
      [String? note, DateTime? start, DateTime? end]) {
    throw UnimplementedError();
  }
}
