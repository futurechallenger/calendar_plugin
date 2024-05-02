import 'package:flutter_test/flutter_test.dart';
import 'package:calendar_plugin/calendar_plugin.dart';
import 'package:calendar_plugin/calendar_plugin_platform_interface.dart';
import 'package:calendar_plugin/calendar_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCalendarPluginPlatform
    with MockPlatformInterfaceMixin
    implements CalendarPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> addEventToCalendar(
    String content, [
    String? note,
    DateTime? start,
    DateTime? end,
  ]) {
    return Future.value(content);
  }
}

void main() {
  final CalendarPluginPlatform initialPlatform =
      CalendarPluginPlatform.instance;

  test('$MethodChannelCalendarPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCalendarPlugin>());
  });

  test('getPlatformVersion', () async {
    CalendarPlugin calendarPlugin = CalendarPlugin();
    MockCalendarPluginPlatform fakePlatform = MockCalendarPluginPlatform();
    CalendarPluginPlatform.instance = fakePlatform;

    expect(await calendarPlugin.getPlatformVersion(), '42');
  });

  test('addEventToCalendar', () async {
    CalendarPlugin calendarPlugin = CalendarPlugin();
    MockCalendarPluginPlatform fakePlatform = MockCalendarPluginPlatform();
    CalendarPluginPlatform.instance = fakePlatform;

    expect(
        await calendarPlugin.addEventToCalendar('hello world'), 'hello world');
  });
}
