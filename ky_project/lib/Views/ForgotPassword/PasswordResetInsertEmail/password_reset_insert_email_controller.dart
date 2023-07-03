import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Services/api_services.dart';
import 'package:ky_project/Commons/Services/ky_api_service.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';

class ForgotPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailFilter;

  final _errorMessage = "".obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(value) => _errorMessage.value = value;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailFilter = TextEditingController();
  }

  @override
  void onClose() {
    emailFilter.dispose();
    super.onClose();
  }

  goToBack() {
    Get.back();
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

    if (errorMessage.isNotEmpty) {
      return errorMessage;
    }

    return null;
  }

  onSubmit() async {
    errorMessage = "";
    bool? validate = formKey.currentState?.validate();
    if (validate != true) {
      return;
    }
    DialogHelper.showDialogLoading();
    await ApiServices().forgotPassword(emailFilter.text.trim()).then((value) {
      DialogHelper.closeDialogLoading();
      if (value) {
        Get.toNamed(AppRoutes.passwordResetConfirm, arguments: {'email': emailFilter.text});
      }
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
      case emailField:
        errorMessage = error.errorMsg;
        break;
      default:
        break;
    }
  }
}
