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
import 'package:ky_project/Helpers/storage_helper.dart';

class LoginController extends GetxController {
  late InAppWebViewController inAppWebViewController;

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailFilter = TextEditingController();
  final TextEditingController passwordFilter = TextEditingController();

  var enableButtonLogin = true.obs;
  String emailFieldServerErrorMessage = "";
  String passwordFieldServerErrorMessage = "";

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

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

  String? passwordValidate(String? value) {
    //Blank fields
    if (passwordFilter.text.trim().isEmpty) {
      return errFieldEmpty;
    }

    if (passwordFieldServerErrorMessage.isNotEmpty) {
      return passwordFieldServerErrorMessage;
    }

    return null;
  }

  void login() {
    emailFieldServerErrorMessage = "";
    passwordFieldServerErrorMessage = "";

    if (!enableButtonLogin.value) {
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    DialogHelper.showDialogLoading();
    _requestLogin(emailFilter.text, passwordFilter.text).then((value) {
      enableButtonLogin.value = true;
      _saveDataLogin(value);
      Get.toNamed(AppRoutes.home);
    }).catchError((error, stackTrace) {
      DialogHelper.closeDialogLoading();
      enableButtonLogin.value = true;
      for (var item in (error as KyException).errors) {
        _catchException(item);
      }
    });
    enableButtonLogin.value = false;
  }

  void goToPasswordReset() {
    Get.toNamed(AppRoutes.passwordResetInsertEmail);
  }

  Future<String> _requestLogin(String email, String password) async {
    try {
      return await ApiServices().login(email.trim(), password.trim());
    } on SocketException {
      throw KyException(errors: [
        KyError(errorMsg: errLoginConnectServer, showType: showErrorPopupType)
      ]);
    } on KyException {
      rethrow;
    } catch (exception) {
      throw KyException(errors: [
        KyError(errorMsg: errLoginOther, showType: showErrorPopupType)
      ]);
    }
  }

  _setFieldServerValidateError(KyError error) {
    switch (error.field) {
      case emailField:
        emailFieldServerErrorMessage = error.errorMsg;
        break;
      case passwordField:
        passwordFieldServerErrorMessage = error.errorMsg;
        break;
      default:
        break;
    }
  }

  void _catchException(KyError error) {
    switch (error.showType) {
      case showErrorPopupType:
        DialogHelper.showDialog(content: error.errorMsg, actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Get.back(),
            child: Text(checkOneTimeCodeDialogBtn,
                style: TextStyle(color: tBlue, fontSize: 12)),
          )
        ]);
        break;
      default:
        _setFieldServerValidateError(error);
        formKey.currentState!.validate();
        break;
    }
  }

  _saveDataLogin(String token) {
    StorageManager.saveData(fkToken, token);
    StorageManager.saveData(fkMailAddress, emailFilter.text.trim());
    StorageManager.saveData(fkPassword, passwordFilter.text.trim());
  }

  _initData() async {
    emailFilter.text = (await StorageManager.readData(fkMailAddress)) ?? "";
    passwordFilter.text = (await StorageManager.readData(fkPassword)) ?? "";
  }

  void autoLogin() async {
    await _initData();

    if (emailFilter.text.isEmpty && passwordFilter.text.isEmpty) {
      Get.toNamed(AppRoutes.login);
      return;
    }

    _requestLogin(emailFilter.text, passwordFilter.text).then((value) {
      _saveDataLogin(value);
      Get.toNamed(AppRoutes.home);
    }).catchError((error, stackTrace) {
      Get.toNamed(AppRoutes.login);
    });
  }
}
