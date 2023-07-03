import 'package:get/get.dart';
import 'package:ky_project/Commons/Services/api_common.dart';

class RecordController extends GetxController {
  // -------------------------------------------------------
  // Field defined
  // -------------------------------------------------------
  CommonApiRequest apiRequest = CommonApiRequest();

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  _initData() async {}
}
