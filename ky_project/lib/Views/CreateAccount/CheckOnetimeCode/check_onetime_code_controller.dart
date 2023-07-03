import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';
import 'package:ky_project/Models/pin_value_model.dart';

class CheckOnetimeCodeController extends GetxController {
  List<PinValue> pinValues = List.generate(6, (index) => PinValue());

  final _textResendBtn = "".obs;
  String get textResendBtn => _textResendBtn.value;
  set textResendBtn(value) => _textResendBtn.value = value;

  final _isCountingDown = true.obs;
  bool get isCountingDown => _isCountingDown.value;
  set isCountingDown(value) => _isCountingDown.value = value;

  final _timer = 15.obs;
  int get timer => _timer.value;
  set timer(value) => _timer.value = value;

  Timer? _timerInstance;

  final _email = "".obs;
  String get email => _email.value;
  set email(String value) => _email.value = value;

  final _errMessage = "".obs;
  String get errMessage => _errMessage.value;
  set errMessage(value) => _errMessage.value = value;

  final _enableBtn = false.obs;
  bool get enableBtn => _enableBtn.value;
  set enableBtn(value) => _enableBtn.value = value;

  @override
  void onInit() {
    super.onInit();
    getArguments();
    isCountingDown = false;
    textResendBtn = checkOneTimeCodeResendBtn;
    errMessage = "";
  }

  @override
  void onClose() {
    _timerInstance?.cancel();
    super.onClose();
  }

  getArguments() {
    final Map<String, dynamic> args = Get.arguments ?? {};
    email = args['email'] ?? "";
  }

  void startCountdown() {
    if (!isCountingDown) {
      isCountingDown = true;
      timer = 15;
      textResendBtn = "$checkOneTimeCodeResendBtn  ($timer)";

      _timerInstance = Timer.periodic(const Duration(seconds: 1), (_) {
        if (timer > 0) {
          timer--;
          textResendBtn = "$checkOneTimeCodeResendBtn  ($timer)";
        } else {
          textResendBtn = checkOneTimeCodeResendBtn;
          stopCountdown();
        }
      });
    }
  }

  void stopCountdown() {
    _timerInstance?.cancel();
    isCountingDown = false;
  }

  onResend() {
    DialogHelper.showDialogLoading();
    startCountdown();
    resendCode();
  }

  void onPinValueChanged(int index, String value) {
    String pin = '';
    for (var pinValue in pinValues) {
      pin += pinValue.controller.text;
    }
    enableBtn = pin.length >= 6;

    if (value.isNotEmpty) {
      bool isNumeric = int.tryParse(value) != null;
      if (isNumeric) {
        if (value.length > 1 && index < 5) {
          String trimmedValue = value.substring(0, 1);
          pinValues[index].controller.text = trimmedValue;
          FocusScope.of(Get.context!).requestFocus(pinValues[index + 1].focusNode);
          pinValues[index + 1].controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: pinValues[index + 1].controller.value.text.length,
          );
          onPinFieldPaste(index + 1, value.substring(1, value.length));
        } else if (index == 5) {
          pinValues[index].controller.text = value[0];
          pinValues[index].controller.selection = TextSelection.fromPosition(TextPosition(offset: pinValues[index].controller.text.length));
        }
      } else {
        pinValues[index].controller.clear();
      }
    } else {
      if (index > 0) {
        FocusScope.of(Get.context!).requestFocus(pinValues[index - 1].focusNode);
      }
    }
  }

  void onPinFieldPaste(int index, String value) {
    int maxLength = 6;
    if (value.isNotEmpty) {
      int tempIndex = 0;
      while (tempIndex < value.length && index < maxLength) {
        bool isNumeric = int.tryParse(value[tempIndex]) != null;
        if (tempIndex < value.length && index < maxLength && isNumeric) {
          pinValues[index].controller.text = value[tempIndex];
          FocusScope.of(Get.context!).requestFocus(pinValues[index].focusNode);
          index++;
        }
        tempIndex++;
      }
    }
  }

  goToBack() {
    Get.back();
  }

  void submitPin() async {
    if (enableBtn) {
      errMessage = "";

      for (var element in pinValues) {
        element.focusNode.unfocus();
      }

      String pin = '';
      for (var pinValue in pinValues) {
        pin += pinValue.controller.text;
      }
      if (pin.length == 6) {
        DialogHelper.showDialogLoading();
        authorizeOnetimeCode(pin);
      } else {
        errMessage = errEmptyPINCode;
      }
    }
  }

  // Call API
  authorizeOnetimeCode(String code) async {
    ApiServices().authorizeOnetimeCode(email, code).then((value) {
      DialogHelper.closeDialogLoading();
      Get.toNamed(AppRoutes.completeRegisterAccount);
    }).catchError((error, stackTrace) {
      DialogHelper.closeDialogLoading();
      DialogHelper.showDialog(content: error.errorMsg, actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Get.back(),
          child: Text(checkOneTimeCodeDialogBtn, style: TextStyle(color: tBlue, fontSize: 12)),
        )
      ]);
    });
  }

  resendCode() {
    ApiServices().resendCode(email).then((value) {
      DialogHelper.closeDialogLoading();
      DialogHelper.showDialog(content: checkOneTimeCodeDialogMsg, actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Get.back(),
          child: Text(checkOneTimeCodeDialogBtn, style: TextStyle(color: tBlue, fontSize: 12)),
        )
      ]);
    }).catchError((error, stackTrace) {
      DialogHelper.closeDialogLoading();
      DialogHelper.showDialog(content: error.errorMsg, actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Get.back(),
          child: Text(checkOneTimeCodeDialogBtn, style: TextStyle(color: tBlue, fontSize: 12)),
        )
      ]);
    });
  }
}
