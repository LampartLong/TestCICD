import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';
import 'package:ky_project/Helpers/dispatch_listener_event.dart';
import 'package:ky_project/Views/Notification/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  late NotificationController controller;
  late InAppWebViewController inAppWebViewController;
  final DateFormat formatter = DateFormat(formatDate);

  final double _dividerHeight = 5;
  double _headerHeight = 60;

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.find<NotificationController>();

    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        onPressed: () {
          DispatchListenerEvent.dispatch(backPageEvent);
        },
      ),
      centerTitle: true,
      title: const Text(appBarTitle),
    );
    _headerHeight = appBar.preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: controller.refreshListNotification,
          child: Obx(
            () => _createListNotificationPageView(context, constraints),
          ),
        ),
      ),
    );
  }

  Widget _webViewBuilder(String url) {
    return Builder(
      builder: (BuildContext context) {
        return InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
              horizontalScrollBarEnabled: false,
              verticalScrollBarEnabled: false,
              disableVerticalScroll: false,
            ),
            android: AndroidInAppWebViewOptions(
              builtInZoomControls: false,
              domStorageEnabled: true,
              displayZoomControls: false,
              useHybridComposition: true,
            ),
            ios: IOSInAppWebViewOptions(
                allowsBackForwardNavigationGestures: true,
                disableLongPressContextMenuOnLinks: true),
          ),
          onWebViewCreated: (InAppWebViewController webViewController) {
            inAppWebViewController = webViewController;
          },
        );
      },
    );
  }

  _createListNotificationPageView(
      BuildContext context, BoxConstraints constraints) {
    if (controller.errorGetListNotification.value) {
      return _createTextContent(
          context, constraints, listNotificationErrorLabel);
    }

    if (controller.lstNotification.isEmpty) {
      return _createTextContent(
          context, constraints, listNotificationEmptyLabel);
    }

    return ListView.separated(
      itemCount: controller.lstNotification.length,
      separatorBuilder: (BuildContext separatorContext, int index) =>
          const Divider(color: Colors.white),
      itemBuilder: (BuildContext listViewContext, int index) {
        var item = controller.lstNotification[index];
        return ListTile(
          title: Text(
            item.title,
            style: Get.context!.textTheme.titleMedium?.copyWith(color: tPurple),
          ),
          subtitle: Text(
              "${formatter.format(item.publishedDate)}\n${item.content}",
              style: Get.context!.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.normal)),
          onTap: () => DialogHelper.showDialogBottomSheet(_createContentPopup(
              constraints.maxHeight +
                  _headerHeight +
                  MediaQuery.of(Get.context!).viewInsets.bottom,
              item.title,
              _webViewBuilder(item.url))),
        );
      },
    );
  }

  _createTextContent(context, constraints, String textContent) {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Text(
                textContent,
                style: Get.context!.textTheme.titleMedium?.copyWith(),
              ),
            )));
  }

  //create popup web-view
  Widget _createContentPopup(double popupHeight, String title, Widget child) {
    return Container(
      height: popupHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          _headerPopup(title),
          Divider(
            height: _dividerHeight,
            color: Colors.black45,
            thickness: 1,
          ),
          SizedBox(
            height: popupHeight - _headerHeight - _dividerHeight,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _headerPopup(String title) {
    return SizedBox(
      height: _headerHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40),
            width: Get.context!.width - 50,
            child: Text(
              title,
              style: Get.context!.textTheme.titleMedium
                  ?.copyWith(overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Get.back(),
            ),
          )
        ],
      ),
    );
  }
}
