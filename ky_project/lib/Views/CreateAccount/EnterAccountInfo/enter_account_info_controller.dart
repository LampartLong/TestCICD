import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/Services/ky_api_service.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';

class EnterAccountInfoController extends GetxController {
  late InAppWebViewController inAppWebViewController;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailFilter = TextEditingController();
  final TextEditingController emailFilterConfirm = TextEditingController();
  final TextEditingController passwordFilter = TextEditingController();
  final TextEditingController passwordConfirmFilter = TextEditingController();

  var enableButtonRequestLogin = false.obs;
  String emailFieldServerErrorMessage = "";
  String passwordFieldServerErrorMessage = "";

  String? emailValidate(String? value) {
    //Blank fields
    if (emailFilter.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    //Invalid email address format
    if (!RegExp(regExpEmail).hasMatch(emailFilter.text.trim())) {
      return errEmailInvalidate;
    }

    if (emailFieldServerErrorMessage.isNotEmpty) {
      return emailFieldServerErrorMessage;
    }

    return null;
  }

  String? emailConfirmValidate(String? value) {
    //Blank fields
    if (emailFilterConfirm.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    //Password and confirm password do not match
    if (emailFilter.text.trim().compareTo(emailFilterConfirm.text.trim()) !=
        0) {
      return errEmailConfirmNotMatch;
    }

    return null;
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

    if (passwordFieldServerErrorMessage.isNotEmpty) {
      return passwordFieldServerErrorMessage;
    }

    return null;
  }

  String? passwordConfirmValidate(String? value) {
    //Blank fields
    if (passwordConfirmFilter.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    //Password and confirm password do not match
    if (passwordFilter.text
            .trim()
            .compareTo(passwordConfirmFilter.text.trim()) !=
        0) {
      return errPasswordConfirmNotMatch;
    }

    return null;
  }

  void checkBoxChange(value) {
    enableButtonRequestLogin.value = value;
  }

  void registerAccount() {
    emailFieldServerErrorMessage = "";

    if (!enableButtonRequestLogin.value) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    DialogHelper.showDialogLoading();
    _createAccount(emailFilter.text, passwordFilter.text).then((value) {
      DialogHelper.closeDialogLoading();
      Get.toNamed(AppRoutes.checkOnetimeCode,
          arguments: {'email': emailFilter.text});
    }).catchError((error, stackTrace) {
      DialogHelper.closeDialogLoading();
      for (var item in (error as KyException).errors) {
        _catchException(item);
      }
    });
  }

  Future<bool> _createAccount(String email, String password) async {
    try {
      return await ApiServices().createAccount(email.trim(), password.trim());
    } on SocketException {
      throw KyException(errors: [
        KyError(errorMsg: errConnectServer, showType: showErrorPopupType)
      ]);
    } on KyException catch (exception) {
      for (var error in exception.errors) {
        _setFieldServerValidateError(error);
      }
      rethrow;
    } catch (exception) {
      throw KyException(
          errors: [KyError(errorMsg: errOther, showType: showErrorPopupType)]);
    }
  }

  _setFieldServerValidateError(KyError exception) {
    switch (exception.field) {
      case emailField:
        emailFieldServerErrorMessage = exception.errorMsg;
        break;
      case passwordField:
        passwordFieldServerErrorMessage = exception.errorMsg;
        break;
      default:
        break;
    }
  }

  void _catchException(KyError exception) {
    switch (exception.showType) {
      case showErrorPopupType:
        DialogHelper.showDialog(content: exception.errorMsg, actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Get.back(),
            child: Text(checkOneTimeCodeDialogBtn,
                style: TextStyle(color: tBlue, fontSize: 12)),
          )
        ]);
        break;
      default:
        formKey.currentState!.validate();
        break;
    }
  }
}
