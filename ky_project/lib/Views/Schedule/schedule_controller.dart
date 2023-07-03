import 'dart:collection';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:ky_project/Helpers/permissions_helper.dart';
import 'package:ky_project/Helpers/storage_helper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/Services/api_common.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Models/schedule_model.dart';

class ScheduleController extends GetxController {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  CommonApiRequest apiRequest = CommonApiRequest();
  final DateFormat formatter = DateFormat(formatDateSchedule);
  final DateFormat formatterRequestApi = DateFormat(formatDateRequestApi);
  final DateFormat formatterTime = DateFormat.Hm();

  late List<Schedule> _lstSchedule = <Schedule>[];
  late Result<UnmodifiableListView<Calendar>> _lstDeviceCalendar;

  final lstAppointment = <Appointment>[].obs;
  final lstScheduleToday = <Schedule>[].obs;
  final lstScheduleSelected = <Schedule>[].obs;
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().month.obs;

  DateTime now = DateTime.now();
  late DateTime rangeStart;
  late DateTime rangeEnd;
  late DeviceCalendarPlugin deviceCalendarPlugin;
  late String calendarID;

  late bool _hasAccessToDeviceCalendar;

  var isDialOpen = ValueNotifier<bool>(false);

  @override
  void onInit() {
    super.onInit();
    rangeStart = DateTime(now.year, now.month - 1, 1);
    rangeEnd = DateTime(now.year, now.month + 2, 0);

    _initData();
  }

  _initData() async {
    await _setupCalendarServerApi();
    await _setupCalendarDevice();
    _syncListScheduleToDevice(_lstSchedule);
    _retrieveDeviceCalendars(rangeStart, rangeEnd);
  }

  isToday(DateTime date) {
    if (DateTime(date.year, date.month, date.day) == DateTime(now.year, now.month, now.day)) {
      return true;
    }

    return false;
  }

  scheduleChangeView(ViewChangedDetails viewChangedDetails) {
    var mid = viewChangedDetails.visibleDates.length ~/ 2.toInt();
    var midDate = viewChangedDetails.visibleDates[0].add(Duration(days: mid));

    if (currentMonth.value == midDate.month) {
      return;
    }

    currentMonth.value = midDate.month;

    //update Appointments
    var visibleDateFirst = viewChangedDetails.visibleDates.first;
    var visibleDateLast = viewChangedDetails.visibleDates.last;

    _updateListAppointment(visibleDateFirst, visibleDateLast);
  }

  bool calendarSelectedDate(DateTime dateSelected) {
    selectedDate.value = dateSelected;
    lstScheduleSelected.value = _getScheduleFromDate(selectedDate.value);
    return true;
  }

  void backSchedule() {
    calendarSelectedDate(selectedDate.value.subtract(const Duration(days: 1)));
  }

  void nextSchedule() {
    calendarSelectedDate(selectedDate.value.add(const Duration(days: 1)));
  }

  String getSubTitle(Schedule schedule) {
    return "${formatterTime.format(schedule.startDatetime)} - ${formatterTime.format(schedule.endDatetime)}";
  }

  Color getColorType(String type) {
    switch (type) {
      case reservationType:
        return tCalendarBlue;
      case recordType:
        return tCalendarGreen;
      default:
        return Colors.blueAccent;
    }
  }

  Future deleteSchedule(Schedule scheduleDelete) async {
    await ApiServices().deleteDataSchedule("").then((value) {
      if (!value) {
        return;
      }

      _deleteEventInCalendarView(scheduleDelete);
      _deleteEventDevice(scheduleDelete);
    });
  }

  _deleteEventInCalendarView(Schedule scheduleDelete) {
    _lstSchedule.remove(scheduleDelete);
    lstScheduleSelected.value.remove(scheduleDelete);
    lstScheduleSelected.refresh();
    lstAppointment.removeWhere((element) => element.id == scheduleDelete.id);
    lstAppointment.refresh();
  }

  _deleteEventDevice(Schedule scheduleDelete) async {
    if (!_hasAccessToDeviceCalendar) {
      return;
    }

    deviceCalendarPlugin.deleteEvent(calendarID, scheduleDelete.eventId);
  }

  Future _setupCalendarDevice() async {
    deviceCalendarPlugin = DeviceCalendarPlugin();
    _hasAccessToDeviceCalendar = await PermissionHelper.hasAccess(PermissionEnum.calendar);

    if (!_hasAccessToDeviceCalendar) {
      return;
    }

    _lstDeviceCalendar = await deviceCalendarPlugin.retrieveCalendars();
    calendarID = await _installCalendar();
  }

  Future _setupCalendarServerApi() async {
    _lstSchedule = await ApiServices().getDataSchedule(_getParam(rangeStart, rangeEnd));
    lstAppointment.value.addAll(_getCalendarDataSource(_lstSchedule));
    lstScheduleToday.value = _getScheduleToday();
    lstScheduleSelected.value = _getScheduleToday();
    lstAppointment.refresh();
  }

  _getScheduleToday() {
    List<Schedule> result = [];

    for (var element in _lstSchedule) {
      if (isToday(element.startDatetime)) {
        result.add(element);
      }
    }

    return result;
  }

  _getScheduleFromDate(DateTime selectedDate) {
    List<Schedule> result = [];
    var checkSelectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    DateTime elementStartDate;
    DateTime elementEndDate;

    for (var element in _lstSchedule) {
      elementStartDate = DateTime(element.startDatetime.year, element.startDatetime.month, element.startDatetime.day);
      elementEndDate = element.endDatetime;

      if (checkSelectedDate == elementStartDate) {
        result.add(element);
      } else if (selectedDate.isAfter(element.startDatetime) && selectedDate.isBefore(elementEndDate)) {
        result.add(element);
      }
    }

    return result;
  }

  String _getParam(DateTime start, DateTime end) {
    if (start.isAfter(end)) {
      return "";
    }

    return "start_date=${formatterRequestApi.format(start)}&end_date=${formatterRequestApi.format(end)}";
  }

  List<Appointment> _getCalendarDataSource(List<Schedule> lst) {
    List<Appointment> appointments = <Appointment>[];

    for (var item in lst) {
      appointments.add(Appointment(
        id: item.id,
        startTime: item.startDatetime,
        endTime: item.endDatetime ?? item.startDatetime,
        subject: item.title,
        color: getColorType(item.type),
      ));
    }

    return appointments;
  }

  void _updateListAppointment(DateTime first, DateTime last) {
    if (first.isBefore(rangeStart)) {
      rangeStart = DateTime(first.year, first.month, 1);
      DateTime end = DateTime(first.year, currentMonth.value, 0);

      _swipeUpdate(rangeStart, end, true);
    }

    if (last.isAfter(rangeEnd)) {
      DateTime start = DateTime(last.year, last.month, 1);
      rangeEnd = DateTime(last.year, last.month + 1, 0);

      _swipeUpdate(start, rangeEnd, false);
    }
  }

  _swipeUpdate(DateTime start, DateTime end, bool leftUpdate) {
    ApiServices().getDataSchedule(_getParam(start, end)).then((value) async {
      if (value.isEmpty) {
        return;
      }

      if (leftUpdate) {
        _lstSchedule.insertAll(0, value);
        lstAppointment.value.insertAll(0, _getCalendarDataSource(value));
      } else {
        _lstSchedule.addAll(value);
        lstAppointment.value.addAll(_getCalendarDataSource(value));
      }

      lstAppointment.refresh();
      _syncListScheduleToDevice(value);
    });

    _retrieveDeviceCalendars(start, end);
  }

  Future<void> _retrieveDeviceCalendars(DateTime start, DateTime end) async {
    if (!_hasAccessToDeviceCalendar) {
      return;
    }

    List<ScheduleDevice> lstFinal = [];
    var scheduleDeviceMap = <String, ScheduleDevice>{};
    if (_lstDeviceCalendar.data != null) {
      for (var element in _lstDeviceCalendar.data!) {
        lstFinal += await _retrieveEvents(element.id!, start, end);
      }
    }
    for (ScheduleDevice element in lstFinal) {
      scheduleDeviceMap["${element.eventTitle.trim()}${element.eventStartDate}${element.eventEndDate}"] = element;
    }

    scheduleDeviceMap.forEach((key, value) {
      var appointment = Appointment(
        id: value.eventId,
        startTime: DateTime.fromMillisecondsSinceEpoch(value.eventStartDate, isUtc: true),
        endTime: DateTime.fromMillisecondsSinceEpoch(value.eventEndDate, isUtc: true),
        subject: value.eventTitle,
        color: getColorType(deviceType),
      );

      _lstSchedule.add(Schedule.fromJsonDevice(value));
      lstAppointment.add(appointment);
    });

    lstAppointment.refresh();
  }

  Future<List<ScheduleDevice>> _retrieveEvents(String calendarId, DateTime start, DateTime end) async {
    try {
      List<ScheduleDevice> lstFinal = [];
      var result = await deviceCalendarPlugin.retrieveEvents(
        calendarId,
        RetrieveEventsParams(startDate: start, endDate: end),
      );

      for (var element in result.data!) {
        lstFinal.add(ScheduleDevice.fromJson(element.toJson()));
      }

      return lstFinal;
    } catch (e) {
      return [];
    }
  }

  void _syncListScheduleToDevice(List<Schedule> schedules) async {
    if (!_hasAccessToDeviceCalendar) {
      return;
    }

    TZDateTime start;
    TZDateTime end;

    for (var schedule in schedules) {
      start = timezone.TZDateTime.from(schedule.startDatetime, timezone.local);

      if (schedule.type == recordType) {
        end = timezone.TZDateTime.from(schedule.startDatetime.add(const Duration(hours: 23)), timezone.local);
      } else {
        end = timezone.TZDateTime.from(schedule.endDatetime, timezone.local);
      }

      Event event = Event(
        calendarID,
        eventId: schedule.id,
        title: schedule.title,
        start: start,
        end: end,
      );

      deviceCalendarPlugin.createOrUpdateEvent(event).then((value) {
        if (value!.isSuccess) {
          schedule.eventId = value.data!;
        }
      });
    }
  }

  Future<String> _installCalendar() async {
    var result = await StorageManager.readData(fkCalendar);

    if (result != null) {
      deviceCalendarPlugin.deleteCalendar(result);
    }

    for (var element in _lstDeviceCalendar.data!) {
      if (element.name == calendarName) {
        deviceCalendarPlugin.deleteCalendar(element.id!);
      }
    }

    result = (await deviceCalendarPlugin.createCalendar(calendarName)).data;
    StorageManager.saveData(fkCalendar, result);

    return result;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
