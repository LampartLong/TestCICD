import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Icons/icons.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';
import 'package:ky_project/Helpers/dispatch_listener_event.dart';
import 'package:ky_project/Views/Schedule/schedule_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatelessWidget {
  late ScheduleController controller;
  CalendarController calendarController = CalendarController();

  SchedulePage({super.key});

  final double _dividerHeight = 5;
  double _headerHeight = 60;

  @override
  Widget build(BuildContext context) {
    controller = Get.find<ScheduleController>();
    calendarController.displayDate = controller.now;
    calendarController.selectedDate = controller.now;
    _headerHeight = _appBar.preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _appBar,
      body: LayoutBuilder(
        builder: (context, constraints) =>
            _createSchedulePageView(context, constraints),
      ),
      floatingActionButton: _floatingActionButton,
    );
  }

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Get.theme.appBarTheme.titleTextStyle?.color),
          onPressed: () {
            DispatchListenerEvent.dispatch(backPageEvent);
          },
        ),
        centerTitle: true,
        title: Obx(() => Text("${controller.currentMonth.value}月")),
      );

  _createSchedulePageView(BuildContext context, BoxConstraints constraints) {
    return Obx(() => SfCalendar(
          controller: calendarController,
          backgroundColor: Colors.white,
          view: CalendarView.month,
          headerHeight: 0,
          dataSource: AppointmentDataSource(controller.lstAppointment.value),
          monthCellBuilder: _monthCellBuilder,
          appointmentBuilder: _appointmentBuilder,
          onTap: (details) => _onCellTap(details, constraints),
          viewHeaderHeight: 30,
          onViewChanged: controller.scheduleChangeView,
          monthViewSettings: const MonthViewSettings(
            showTrailingAndLeadingDates: true,
            showAgenda: false,
            appointmentDisplayCount: 3,
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
        ));
  }

  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) {
    var mid = details.visibleDates.length ~/ 2.toInt();
    var midDate = details.visibleDates[0].add(Duration(days: mid));

    if (details.date.month != midDate.month) {
      return Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: lineCalendar),
                bottom: BorderSide(color: lineCalendar))),
        child: const Text(""),
      );
    }
    Color labelColor = Colors.black;

    if (details.date.weekday == DateTime.saturday) {
      labelColor = tCalendarCretanGreen;
    }

    if (details.date.weekday == DateTime.sunday) {
      labelColor = tCalendarMelon;
    }

    if (controller.isToday(details.date)) {
      return Container(
        padding: const EdgeInsets.all(3),
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: lineCalendar),
                bottom: BorderSide(color: lineCalendar))),
        child: Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: tCalendarCretanGreen,
          ),
          child: Text(details.date.day.toString(),
              style: Get.context!.textTheme.labelSmall
                  ?.copyWith(color: Colors.white)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(5),
      alignment: Alignment.topRight,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: lineCalendar),
              bottom: BorderSide(color: lineCalendar))),
      child: Text(details.date.day.toString(),
          style:
              Get.context!.textTheme.labelSmall?.copyWith(color: labelColor)),
    );
  }

  Widget _appointmentBuilder(context, details) {
    if (details.date.month != controller.currentMonth.value) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.only(left: 2),
      padding: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2),
        color: (details.appointments.first as Appointment).color,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        (details.appointments.first as Appointment).subject,
        maxLines: 2,
        overflow: TextOverflow.clip,
        style: Get.textTheme.labelSmall?.copyWith(
            height: 1, fontSize: 8, wordSpacing: 0, color: Colors.white),
      ),
    );
  }

  void _onCellTap(CalendarTapDetails details, BoxConstraints constraints) {
    if (details.date!.month != controller.currentMonth.value) {
      return;
    }

    double popupHeight = constraints.maxHeight +
        _headerHeight +
        MediaQuery.of(Get.context!).viewInsets.bottom;

    controller.calendarSelectedDate(details.date!);
    DialogHelper.showDialogBottomSheet(
        _createContentPopup(popupHeight, Obx(() => _createListSchedule)),
        enableDrag: true);
  }

  Widget _createContentPopup(double popupHeight, Widget child) {
    return Container(
      height: popupHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          _headerPopup(),
          Divider(height: _dividerHeight, color: Colors.black45, thickness: 1),
          SizedBox(
            height: popupHeight - _headerHeight - _dividerHeight,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _headerPopup() {
    return SizedBox(
      height: _headerHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buttonBack, _titleHeaderPopup, _btnNext],
      ),
    );
  }

  Widget get _buttonBack => SizedBox(
        width: 50,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            controller.backSchedule();

            if (controller.selectedDate.value.month !=
                controller.currentMonth.value) {
              calendarController.backward!.call();
              controller.currentMonth.value =
                  controller.selectedDate.value.month;
            }

            calendarController.selectedDate = controller.selectedDate.value;
            calendarController.displayDate = controller.selectedDate.value;
          },
        ),
      );

  Widget get _btnNext => SizedBox(
        width: 50,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            controller.nextSchedule();

            if (controller.selectedDate.value.month !=
                controller.currentMonth.value) {
              calendarController.forward!.call();
              controller.currentMonth.value =
                  controller.selectedDate.value.month;
            }

            calendarController.selectedDate = controller.selectedDate.value;
            calendarController.displayDate = controller.selectedDate.value;
          },
        ),
      );

  Widget get _titleHeaderPopup => SizedBox(
        width: Get.context!.width - 100,
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Image.asset(
                clock,
                width: 25,
                height: 25,
              )),
              const WidgetSpan(
                  child: SizedBox(
                width: 10,
              )),
              WidgetSpan(
                  child: Obx(() => Text(
                        "${controller.formatter.format(controller.selectedDate.value)}(${weekdays[controller.selectedDate.value.weekday - 1]})",
                        style: Get.context!.textTheme.titleMedium
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                      ))),
            ])),
      );

  Widget get _createListSchedule {
    if (controller.lstScheduleSelected.value.isEmpty) {
      return Center(
        child: Text(
          listScheduleDayEmptyLabel,
          style: Get.context!.textTheme.titleMedium?.copyWith(),
        ),
      );
    }

    return ListView.separated(
      itemCount: controller.lstScheduleSelected.value.length,
      itemBuilder: (context, index) {
        var item = controller.lstScheduleSelected.value[index];

        return ListTile(
          contentPadding: const EdgeInsets.only(left: 20, right: 10),
          title: Text(item.title,
              style: Get.context!.textTheme.titleMedium
                  ?.copyWith(color: controller.getColorType(item.type))),
          subtitle: item.type == recordType
              ? null
              : Text(controller.getSubTitle(item)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: "fab_$index",
                onPressed: () {
                  Get.back();
                  DispatchListenerEvent.dispatch(pushPageEvent, data: 2);
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.edit_outlined),
              ),
              const SizedBox(width: 5),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.deleteSchedule(item))
            ],
          ),
        );
      },
      separatorBuilder: (separatorContext, index) =>
          const Divider(color: Colors.grey),
    );
  }

  Widget get _floatingActionButton => SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: bPurpleDefault,
        childPadding: const EdgeInsets.all(2),
        foregroundColor: Colors.white,
        spaceBetweenChildren: 10,
        openCloseDial: controller.isDialOpen,
        children: [
          SpeedDialChild(
            labelBackgroundColor: Colors.transparent,
            child: Image.asset(
              recordIcons,
              width: Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,
              height:
                  Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,
            ),
            labelWidget: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(lblActionButtonRecord),
            ),
            onTap: () => DispatchListenerEvent.dispatch(pushPageEvent, data: 2),
          ),
          SpeedDialChild(
            child: Image.asset(
              scheduleIcons,
              width: Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,
              height:
                  Get.theme.bottomNavigationBarTheme.selectedIconTheme!.size,
            ),
            labelWidget: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(lblActionButtonSchedule),
            ),
            onTap: () => DispatchListenerEvent.dispatch(pushPageEvent, data: 2),
          ),
        ],
      );
}
