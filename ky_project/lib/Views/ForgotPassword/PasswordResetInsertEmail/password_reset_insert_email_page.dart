import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Views/ForgotPassword/PasswordResetInsertEmail/password_reset_insert_email_controller.dart';
import 'dart:math' as math;
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/form_custom.dart';

class PasswordResetInsertEmailPage extends StatelessWidget {
  PasswordResetInsertEmailPage({Key? key}) : super(key: key);
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          controller.goToBack();
          return true;
        },
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: backgroundLinearGradient,
                transform: const GradientRotation(math.pi / 4),
              ),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).appBarTheme.titleTextStyle?.color),
                    onPressed: controller.goToBack,
                  ),
                  backgroundColor: Colors.transparent,
                  title: const Text(passwordResetAppBarTitle),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    const Text(
                      passwordResetLabel,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 48),
                    FormCustom(
                      formKey: controller.formKey,
                      children: [
                        TextFieldCustom(
                          controller: controller.emailFilter,
                          hintText: hntEmail,
                          maxLength: emailMaxLength,
                          validator: controller.emailValidate,
                          label: lblEmail,
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    KyButton.standard(
                      style: ButtonStandardStyle.purple,
                      onPressed: controller.onSubmit,
                      label: passwordResetBtn,
                    ),
                  ]),
                ))));
  }
}
