import 'package:device_calendar/device_calendar.dart';

class PermissionHelper {
  static final DeviceCalendarPlugin _deviceCalendarPlugin =
      DeviceCalendarPlugin();

  static requestPermissions() {
    //request permission calendar
    _deviceCalendarPlugin.requestPermissions();
  }

  static Future<bool> hasAccess(PermissionEnum permission) async {
    switch (permission) {
      case PermissionEnum.calendar:
        return (await _deviceCalendarPlugin.hasPermissions()).data ?? false;
      default:
        return false;
    }
  }
}

enum PermissionEnum {
  calendar,
  internet,
}
