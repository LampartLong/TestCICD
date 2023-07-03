import 'package:get/get.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dispatch_listener_event.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  final List<int> listScreen = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
    _initEvent();
  }

  @override
  void onClose() {
    DispatchListenerEvent.remove(pushPageEvent, pushPageEvent);
    DispatchListenerEvent.remove(backPageEvent, backPageEvent);
    super.onClose();
  }

  _initData() async {
    listScreen.add(selectedIndex.value);
  }

  _initEvent() {
    DispatchListenerEvent.listener(pushPageEvent, pushPage, pushPageEvent);
    DispatchListenerEvent.listener(backPageEvent, backPage, backPageEvent);
  }

  pushPage(int indexPage) {
    if (listScreen.isNotEmpty && listScreen.last == indexPage) {
      return;
    }

    listScreen.add(indexPage);
    selectedIndex.value = indexPage;
  }

  backPage() {
    if (listScreen.length == 1) {
      return;
    }

    listScreen.removeLast();
    selectedIndex.value = listScreen.last;
  }
}
