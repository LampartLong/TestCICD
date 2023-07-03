import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Icons/icons.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Views/Notification/notification_controller.dart';
import 'package:ky_project/Views/Schedule/schedule_controller.dart';
import 'package:ky_project/Views/Top/top_controller.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/clip_rrect_blur.dart';

class TopPage extends StatelessWidget {
  late TopController controller;
  late NotificationController notificationController;
  late ScheduleController scheduleController;
  final ScrollController _scrollController = ScrollController();

  TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(TopController());
    notificationController = Get.find<NotificationController>();
    scheduleController = Get.find<ScheduleController>();

    return WillPopScope(
      onWillPop: () async {
        return true;
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
            body: _contentTopPage,
          ),
        ],
      ),
    );
  }

  Widget get _contentTopPage {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Stack(
        children: [
          Positioned(
            top: -(Get.width * 3 / 5),
            left: 0,
            child: Container(
              width: Get.width,
              height: Get.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(Get.width, Get.width - 180),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Wrap(
              runSpacing: 20,
              children: [
                SizedBox(
                    height: MediaQuery.of(Get.context!).padding.top,
                    width: double.infinity),
                _email,
                _avatar,
                _plan,
                _document,
                _notification,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _email {
    return Obx(() => Text(
          controller.greeting.value,
          style: Get.context!.textTheme.labelLarge?.copyWith(
            color: tPurple,
          ),
        ));
  }

  Widget get _avatar {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 35,
        child: getAvatar() ??
            InkWell(
              onTap: controller.updateAvatar,
              child: Image.asset(
                camera,
                width: 35,
                height: 35,
                color: bPurpleDefault,
              ),
            ),
      ),
    );
  }

  Widget? getAvatar() {
    return null;
  }

  Widget get _plan {
    return ClipRRectBlur(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Wrap(
          spacing: 20,
          children: [
            SizedBox(
                width: double.infinity,
                child: Text(
                  "${controller.date}(${controller.weekday})",
                  style: Get.context!.textTheme.labelLarge?.copyWith(
                    color: tPurple,
                  ),
                )),
            SizedBox(
              width: double.infinity,
              child: Text(lblTodayPlan,
                  style: Get.context!.textTheme.labelLarge?.copyWith(
                    color: tPurple,
                  )),
            ),
            Obx(() => _getTodayPlan),
            const SizedBox(height: 20, width: double.infinity),
            SizedBox(
              width: Get.width / 3,
              height: 90,
              child: KyButton.square(
                onPressed: controller.recordClick,
                label: lblRecordButton,
                icon: recordIcons,
                style: ButtonSquareStyle.purple,
              ),
            ),
            SizedBox(
              width: Get.width / 3,
              height: 90,
              child: KyButton.square(
                onPressed: controller.scheduleClick,
                label: lblScheduleButton,
                icon: scheduleIcons,
                style: ButtonSquareStyle.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _getTodayPlan {
    List<Widget> lst = [];

    for (var element in scheduleController.lstScheduleToday) {
      lst.add(const SizedBox(height: 5));
      lst.add(RichText(
        text: TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                    width: 50,
                    height: 25,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Text(
                      controller.formatterTime.format(element.startDatetime),
                      style: TextStyle(color: tCalendarBlue, fontSize: 14),
                    ))),
            TextSpan(
              text: element.title,
              style: TextStyle(color: tPurple, fontSize: 14),
            ),
          ],
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lst,
    );
  }

  Widget get _document {
    return Wrap(
      children: [
        ClipRRectBlur(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              spacing: 20,
              children: [
                Text(
                  lblDocument,
                  style: Get.context!.textTheme.labelLarge?.copyWith(
                    color: tPurple,
                  ),
                ),
                const SizedBox(height: 10, width: double.infinity),
                Text(
                  lblDocumentDescription,
                  style: Get.context!.textTheme.labelSmall?.copyWith(
                    color: tPurple,
                  ),
                ),
                const SizedBox(height: 20, width: double.infinity),
                Center(
                  child: SizedBox(
                    width: Get.width / 3,
                    height: 90,
                    child: KyButton.square(
                      onPressed: controller.documentClick,
                      label: lblDocumentButton,
                      icon: folderPlus,
                      style: ButtonSquareStyle.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 5, width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(color: bPurpleDefault),
        )
      ],
    );
  }

  Widget get _notification {
    return Wrap(
      children: [
        Center(
          child: Text(
            lblNotification,
            style: Get.context!.textTheme.labelLarge
                ?.copyWith(color: tPurple, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20, width: double.infinity),
        _slideNotification
      ],
    );
  }

  Widget get _slideNotification {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: bPurpleDefault),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() => notificationController.lstNotification.value.isEmpty
            ? Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  listNotificationEmptyLabel,
                  style: Get.context!.textTheme.labelSmall?.copyWith(
                    color: tPurple,
                  ),
                ),
              )
            : _getCurrentNotification()),
      ),
    );
  }

  Widget _getCurrentNotification() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationController.lstNotification
                    .value[controller.indexNotification.value].title,
                style: Get.context!.textTheme.labelLarge?.copyWith(
                  color: tPurple,
                ),
              ),
              Text(
                controller.formatter.format(notificationController
                    .lstNotification
                    .value[controller.indexNotification.value]
                    .publishedDate),
                style: Get.context!.textTheme.labelSmall?.copyWith(
                  color: tPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                notificationController.lstNotification
                    .value[controller.indexNotification.value].content,
                style: Get.context!.textTheme.labelSmall?.copyWith(
                  color: tPurple,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => (controller.indexNotification.value == 0)
                  ? const SizedBox(
                      width: 25,
                    )
                  : InkWell(
                      onTap: () {
                        controller.slideNotificationLeft();
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      child: Image.asset(
                        arrowLeftCircle,
                        width: 25,
                        height: 25,
                        color: bPurpleDefault,
                      ),
                    )),
              Obx(() => (controller.indexNotification.value >=
                      notificationController.lstNotification.value.length - 1)
                  ? const SizedBox(
                      width: 25,
                    )
                  : InkWell(
                      onTap: () {
                        controller.slideNotificationRight();
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      child: Image.asset(
                        arrowRightCircle,
                        width: 25,
                        height: 25,
                        color: bPurpleDefault,
                      ),
                    ))
            ],
          ),
        ),
      ],
    );
  }
}
