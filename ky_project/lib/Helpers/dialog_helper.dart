import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static showDialogLoading() {
    return Get.generalDialog(
        barrierDismissible: false,
        barrierLabel: "",
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const CupertinoAlertDialog(
            content: Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                  Text("Please wait ...")
                ]),
          );
        });
  }

  static closeDialogLoading() {
    Get.back();
  }

  static showDialog(
      {String? title = "",
      String? content = "",
      bool? barrierDismissible = true,
      List<CupertinoDialogAction>? actions}) {
    return Get.generalDialog(
        barrierDismissible: barrierDismissible!,
        barrierLabel: title,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return CupertinoAlertDialog(
            title: title!.isEmpty ? null : Text(title),
            content: content!.isEmpty ? null : Text(content),
            actions: actions ?? [],
          );
        });
  }

  static showDialogBottomSheet(Widget child, {bool enableDrag = false}) {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0),
      barrierColor: Colors.black.withOpacity(0),
      enableDrag: enableDrag,
    );
  }
}
