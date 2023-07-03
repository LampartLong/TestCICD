import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Icons/icons.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dispatch_listener_event.dart';
import 'package:ky_project/Views/Home/home_controller.dart';
import 'package:ky_project/Views/Notification/notification_page.dart';
import 'package:ky_project/Views/Record/record_page.dart';
import 'package:ky_project/Views/Schedule/schedule_controller.dart';
import 'package:ky_project/Views/Schedule/schedule_page.dart';
import 'package:ky_project/Views/Top/top_page.dart';
import 'package:ky_project/Views/WidgetCommon/bottom_navigation_bar_custom.dart';

class HomePage extends StatelessWidget {
  late HomeController controller;
  late ScheduleController scheduleController;
  final List<Widget> _widgetOptions = [];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(HomeController());
    scheduleController = Get.find<ScheduleController>();
    _widgetOptions.addAll([
      topPage,
      notificationPage,
      recordPage,
      schedulePage,
      bodyPage5,
    ]);

    return WillPopScope(
      onWillPop: () async {
        if (scheduleController.isDialOpen.value) {
          scheduleController.isDialOpen.value = false;
          return false;
        }

        DispatchListenerEvent.dispatch(backPageEvent);
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: backgroundLinearGradient,
                  transform: const GradientRotation(math.pi / 4),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(
              () => IndexedStack(
                index: controller.selectedIndex.value,
                children: _widgetOptions,
              ),
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBarCustom(
                currentIndex: controller.selectedIndex.value,
                onTap: (index) => controller.pushPage(index),
                children: [
                  BottomNavigationBarItemCustom.create(
                      icon: homeIcons, label: lblHome),
                  BottomNavigationBarItemCustom.create(
                      icon: bellIcons, label: lblNotification),
                  BottomNavigationBarItemCustom.create(
                      icon: recordIcons, label: lblRecord),
                  BottomNavigationBarItemCustom.create(
                      icon: scheduleIcons, label: lblSchedule),
                  BottomNavigationBarItemCustom.create(
                      icon: settingsIcons, label: lblSettings),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get topPage => TopPage();

  Widget get notificationPage => NotificationPage();

  Widget get recordPage => RecordPage();

  Widget get schedulePage => SchedulePage();

  Widget get bodyPage5 => const Center(
        child: Text(
          'Index 5: $lblSettings',
        ),
      );
}
