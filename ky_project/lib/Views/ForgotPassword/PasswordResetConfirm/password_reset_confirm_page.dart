import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Icons/icons.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Views/ForgotPassword/PasswordResetConfirm/password_reset_confirm_controller.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/form_custom.dart';
import 'package:ky_project/Views/WidgetCommon/tooltip_custom.dart';

class PasswordResetConfirmPage extends StatelessWidget {
  final PasswordResetConfirmController controller = Get.put(PasswordResetConfirmController());

  PasswordResetConfirmPage({super.key});

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
                title: const Text(passwordResetConfirmAppbarTitle),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      Text(
                        "${controller.email}$checkOneTimeCodeLabel",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          passwordResetConfirmPinLbl,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: tPurple,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                (index) => Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: 54,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: tWhite,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: TextFormField(
                                      controller: controller.pinValues[index].controller,
                                      focusNode: controller.pinValues[index].focusNode,
                                      onChanged: (value) => controller.onPinValueChanged(index, value),
                                      onFieldSubmitted: (_) => controller.submitPin(),
                                      inputFormatters: [NumberInputFormatter()],
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                      Obx(() {
                        return Text(
                          controller.errMessagePin,
                          style: TextStyle(
                            fontSize: 12,
                            color: tError,
                          ),
                        );
                      }),
                      FormCustom(
                        formKey: controller.formKey,
                        children: [
                          TextFieldCustom(
                            controller: controller.passwordFilter,
                            hintText: passwordResetConfirmPasswordHint,
                            maxLength: passwordMaxLength,
                            obscureText: true,
                            validator: controller.passwordValidate,
                            onChanged: controller.onChangePassword,
                            labelChild: RichText(
                              text: TextSpan(
                                text: passwordResetConfirmPasswordLbl,
                                style: TextStyle(fontSize: 16, color: tPurple),
                                children: <WidgetSpan>[
                                  WidgetSpan(
                                      baseline: TextBaseline.alphabetic,
                                      alignment: PlaceholderAlignment.aboveBaseline,
                                      child: TooltipCustom.standard(Image.asset(bulbIcons), lblPasswordTooltip))
                                ],
                              ),
                            ),
                          ),
                          TextFieldCustom(
                            controller: controller.passwordConfirmFilter,
                            hintText: passwordResetConfirmPasswordConfirmHint,
                            obscureText: true,
                            maxLength: passwordMaxLength,
                            onChanged: controller.onChangePasswordConfirm,
                            validator: controller.passwordConfirmValidate,
                            label: passwordResetConfirmPasswordConfirmLbl,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() => KyButton.standard(
                          style: controller.enableBtn ? ButtonStandardStyle.purple : ButtonStandardStyle.purpleDisable,
                          onPressed: controller.submitPin,
                          iconAlign: IconButtonAlignment.left,
                          label: passwordResetConfirmBtn)),
                    ],
                  ),
                ),
              )),
        ));
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
