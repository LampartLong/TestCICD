import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dispatch_listener_event.dart';

class TopController extends GetxController {
  var greeting = lblGreeting.obs;
  var indexNotification = 0.obs;

  String date = DateFormat(formatDateNoSpace).format(DateTime.now());
  final DateFormat formatter = DateFormat(formatDateTop);
  final DateFormat formatterTime = DateFormat.Hm();
  String weekday = weekdays[DateTime.now().weekday - 1];

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  _initData() {
    greeting.value = getGreeting();
  }

  String getGreeting() {
    return lblGreeting;
  }

  updateAvatar() {}

  recordClick() {
    DispatchListenerEvent.dispatch(pushPageEvent, data: 2);
  }

  scheduleClick() {
    DispatchListenerEvent.dispatch(pushPageEvent, data: 3);
  }

  documentClick() {}

  slideNotificationLeft() {
    if (indexNotification.value == 0) {
      return;
    }

    indexNotification.value--;
  }

  slideNotificationRight() {
    indexNotification.value++;
  }
}
