import 'package:get/get.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/Services/api_common.dart';
import 'package:ky_project/Models/notification_model.dart';

class NotificationController extends GetxController {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  CommonApiRequest apiRequest = CommonApiRequest();

  final lstNotification = <Notification>[].obs;
  var errorGetListNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> refreshListNotification() async {
    try {
      errorGetListNotification.value = false;
      lstNotification.value = await ApiServices().getDataNotification();
    } catch (ex) {
      errorGetListNotification.value = true;
    }
  }

  _initData() async {
    refreshListNotification();
  }
}
