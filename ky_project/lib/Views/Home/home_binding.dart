import 'package:get/get.dart';
import 'package:ky_project/Views/Notification/notification_controller.dart';
import 'package:ky_project/Views/Record/record_controller.dart';
import 'package:ky_project/Views/Schedule/schedule_controller.dart';
import 'package:ky_project/Views/Top/top_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopController>(() => TopController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<ScheduleController>(() => ScheduleController());
    Get.lazyPut<RecordController>(() => RecordController());
  }
}