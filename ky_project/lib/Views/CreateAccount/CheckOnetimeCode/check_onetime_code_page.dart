import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Views/CreateAccount/CheckOnetimeCode/check_onetime_code_controller.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/tooltip_custom.dart';

class CheckOneTimeCodePage extends StatelessWidget {
  final CheckOnetimeCodeController controller =
      Get.put(CheckOnetimeCodeController());

  CheckOneTimeCodePage({super.key});

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
                title: const Text(appBarTitleCheckOnetimeCode),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Text(
                      "${controller.email}$checkOneTimeCodeLabel",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: tWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: TextFormField(
                                    controller:
                                        controller.pinValues[index].controller,
                                    focusNode:
                                        controller.pinValues[index].focusNode,
                                    onChanged: (value) => controller
                                        .onPinValueChanged(index, value),
                                    onFieldSubmitted: (_) =>
                                        controller.submitPin(),
                                    inputFormatters: [NumberInputFormatter()],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(controller.errMessage, style: Get.textTheme.bodyMedium?.copyWith(color: tError)),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => KyButton.standard(
                        style: controller.enableBtn
                            ? ButtonStandardStyle.purple
                            : ButtonStandardStyle.purpleDisable,
                        onPressed: controller.submitPin,
                        label: checkOneTimeCodeConfirmBtn)),
                    Obx(() => TextButton(
                        onPressed: controller.isCountingDown
                            ? null
                            : controller.onResend,
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return tGrey; // Màu xám cho trạng thái bị vô hiệu hóa
                            }
                            return tBlack; // Màu đen cho trạng thái bình thường
                          }),
                        ),
                        child: Text(
                          controller.textResendBtn,
                        ))),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TooltipCustom.standard(
                            Text(
                              checkOneTimeCodeInfoBtn,
                              style: context.textTheme.labelSmall?.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            checkOneTimeCodeHintMsg)
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}
