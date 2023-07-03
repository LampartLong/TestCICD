import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Views/Login/login_controller.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/form_custom.dart';

class LoginPage extends StatelessWidget {
  late LoginController controller;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.find<LoginController>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: backgroundLinearGradient,
                  transform: const GradientRotation(math.pi / 4),
                ),
              ),
            ),
          ),
          SafeArea(
              child: Scaffold(
            backgroundColor: Colors.transparent,
            body: contentLogin,
          )),
        ],
      ),
    );
  }

  Widget get contentLogin {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: <Widget>[
            _createLogo,
            _createForm,
            const SizedBox(height: 30),
            _createButtonLogin,
            const SizedBox(height: 5),
            _linkForgotPassword,
            const SizedBox(height: 20),
            _labelRegisterAccount,
            const SizedBox(height: 5),
            _createButtonRegisterAccount,
          ],
        ),
      ),
    );
  }

  //create logo
  Widget get _createLogo {
    return SizedBox(
      height: 200,
      child: Center(child: Image.asset(logo)),
    );
  }

  //create form
  Widget get _createForm {
    return FormCustom(
      formKey: controller.formKey,
      children: [
        TextFieldCustom(
          controller: controller.emailFilter,
          hintText: hntEmail,
          maxLength: emailMaxLength,
          validator: controller.emailValidate,
          label: lblEmail,
        ),
        TextFieldCustom(
          controller: controller.passwordFilter,
          hintText: hntPassword,
          maxLength: passwordMaxLength,
          obscureText: true,
          validator: controller.passwordValidate,
          label: lblPassword,
        ),
      ],
    );
  }

  //create button login
  Widget get _createButtonLogin {
    return SizedBox(
      height: 50,
      child: Obx(
        () => KyButton.standard(
          onPressed: controller.login,
          label: lblLoginButton,
          iconAlign: IconButtonAlignment.left,
          style: !controller.enableButtonLogin.value
              ? ButtonStandardStyle.purpleDisable
              : ButtonStandardStyle.purple,
        ),
      ),
    );
  }

  //create link forgot password
  Widget get _linkForgotPassword {
    return RichText(
      text: TextSpan(
        text: lblForgotPassword,
        style:
            Get.context!.textTheme.labelMedium?.copyWith(color: Colors.black),
        children: <InlineSpan>[
          WidgetSpan(
              child: InkWell(
                  onTap: controller.goToPasswordReset,
                  child: Text(
                    lblForgotPasswordLink,
                    style: Get.context!.textTheme.labelSmall?.copyWith(
                      color: tGrey,
                      decoration: TextDecoration.underline,
                    ),
                  )))
        ],
      ),
    );
  }

  Widget get _labelRegisterAccount => Text(
        lblRegisterAccount,
        style: Get.context!.textTheme.labelSmall?.copyWith(color: Colors.black),
      );

  //create button register account
  Widget get _createButtonRegisterAccount {
    return SizedBox(
      height: 50,
      child: KyButton.standard(
        onPressed: () => Get.toNamed(AppRoutes.enterAccountInfo),
        label: lblRegisterAccountButton,
        iconAlign: IconButtonAlignment.left,
        style: ButtonStandardStyle.purple,
      ),
    );
  }
}
