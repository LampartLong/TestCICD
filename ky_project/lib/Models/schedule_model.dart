import 'package:ky_project/Commons/app_const.dart';

class Schedule {
  late String title;
  late String id;
  late String eventId;
  late String type;
  late DateTime startDatetime;
  late DateTime endDatetime;

  Schedule(
      {required this.id,
      required this.type,
      required this.title,
      required this.startDatetime,
      required this.endDatetime});

  factory Schedule.fromJson(Map<dynamic, dynamic> json) {
    DateTime start = DateTime.parse(json['start_datetime'] ?? json['date']);
    DateTime end = json['end_datetime'] != null
        ? DateTime.parse(json['end_datetime'])
        : start.add(const Duration(hours: 23, minutes: 59));

    return Schedule(
      id: json['start_datetime'] ?? json['date'],
      type: json['type'],
      title: json['title'],
      startDatetime: start,
      endDatetime: end,
    );
  }

  factory Schedule.fromJsonDevice(ScheduleDevice scheduleDevice) {
    return Schedule(
      id: scheduleDevice.calendarId,
      type: deviceType,
      title: scheduleDevice.eventTitle,
      startDatetime: DateTime.fromMillisecondsSinceEpoch(
          scheduleDevice.eventStartDate,
          isUtc: true),
      endDatetime: DateTime.fromMillisecondsSinceEpoch(
          scheduleDevice.eventEndDate,
          isUtc: true),
    );
  }
}

class ScheduleDevice {
  late String calendarId;
  late String eventId;
  late String eventTitle;
  late String eventDescription;
  late int eventStartDate;
  late int eventEndDate;

  ScheduleDevice(
      {required this.calendarId,
      required this.eventId,
      required this.eventTitle,
      required this.eventDescription,
      required this.eventStartDate,
      required this.eventEndDate});

  factory ScheduleDevice.fromJson(Map<dynamic, dynamic> json) {
    return ScheduleDevice(
      calendarId: json['calendarId'],
      eventId: json['eventId'],
      eventTitle: json['eventTitle'],
      eventDescription: json['eventDescription'],
      eventStartDate: json['eventStartDate'],
      eventEndDate: json['eventEndDate'],
    );
  }
}
