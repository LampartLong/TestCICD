import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/Services/ky_api_service.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';
import 'package:ky_project/Models/pin_value_model.dart';

class PasswordResetConfirmController extends GetxController {
  List<PinValue> pinValues = List.generate(6, (index) => PinValue());

  final _email = "".obs;
  String get email => _email.value;
  set email(String value) => _email.value = value;

  final _errMessagePin = "".obs;
  String get errMessagePin => _errMessagePin.value;
  set errMessagePin(value) => _errMessagePin.value = value;

  final _errMessage = "".obs;
  String get errMessage => _errMessage.value;
  set errMessage(value) => _errMessage.value = value;

  final _enableBtn = false.obs;
  bool get enableBtn => _enableBtn.value;
  set enableBtn(value) => _enableBtn.value = value;

  late GlobalKey<FormState> formKey;
  late TextEditingController passwordFilter;
  late TextEditingController passwordConfirmFilter;

  @override
  void onInit() {
    super.onInit();
    getArguments();
    errMessagePin = "";
    errMessage = "";
    formKey = GlobalKey<FormState>();
    passwordFilter = TextEditingController();
    passwordConfirmFilter = TextEditingController();
  }

  getArguments() {
    final Map<String, dynamic> args = Get.arguments ?? {};
    email = args['email'] ?? "";
  }

  String? passwordValidate(String? value) {
    //Blank fields
    if (passwordFilter.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    //Password must meet the requirements
    if (!RegExp(regExpPassword).hasMatch(passwordFilter.text.trim())) {
      return errPasswordInvalidate;
    }

    if (errMessage.isNotEmpty) {
      return errMessage;
    }

    return null;
  }

  String? passwordConfirmValidate(String? value) {
    //Blank fields
    if (passwordConfirmFilter.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    //Password and confirm password do not match
    if (passwordFilter.text.trim().compareTo(passwordConfirmFilter.text.trim()) != 0) {
      return errPasswordConfirmNotMatch;
    }

    return null;
  }

  void onPinValueChanged(int index, String value) {
    checkBtnEnable();

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

  onChangePassword(String value) {
    checkBtnEnable();
  }

  onChangePasswordConfirm(String value) {
    checkBtnEnable();
  }

  checkBtnEnable() {
    String pin = '';
    for (var pinValue in pinValues) {
      pin += pinValue.controller.text;
    }
    String password = passwordFilter.text.trim();
    String passwordConfirm = passwordConfirmFilter.text.trim();

    enableBtn = password.isNotEmpty && passwordConfirm.isNotEmpty && pin.length >= 6;
  }

  goToBack() {
    Get.back();
  }

  void submitPin() async {
    if (enableBtn) {
      errMessage = "";
      errMessagePin = "";

      for (var element in pinValues) {
        element.focusNode.unfocus();
      }

      String pin = '';
      for (var pinValue in pinValues) {
        pin += pinValue.controller.text;
      }
      if (pin.length == 6) {
        if (!formKey.currentState!.validate()) {
          return;
        }

        DialogHelper.showDialogLoading();
        forgotPasswordConfirm(pin);
      } else {
        errMessagePin = errEmptyPINCode;
      }
    }
  }

  // Call API
  forgotPasswordConfirm(String code) async {
    ApiServices().forgotPasswordConfirm(email, passwordFilter.text, code).then((value) {
      DialogHelper.closeDialogLoading();
      Get.toNamed(AppRoutes.passwordResetComplete);
    }).catchError((error, stackTrace) {
      DialogHelper.closeDialogLoading();
      for (var item in (error as KyException).errors) {
        _catchException(item);
      }
    });
  }

  void _catchException(KyError error) {
    switch (error.showType) {
      case showErrorPopupType:
        DialogHelper.showDialog(content: error.errorMsg, actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Get.back(),
            child: Text(checkOneTimeCodeDialogBtn, style: TextStyle(color: tBlue, fontSize: 12)),
          )
        ]);
        break;
      default:
        _setFieldServerValidateError(error);
        formKey.currentState!.validate();
        break;
    }
  }

  _setFieldServerValidateError(KyError error) {
    switch (error.field) {
      case passwordField:
        errMessage = error.errorMsg;
        break;
      case emailField:
        errMessage = error.errorMsg;
        break;
      case codeField:
        errMessagePin = error.errorMsg;
        break;
    }
  }
}
