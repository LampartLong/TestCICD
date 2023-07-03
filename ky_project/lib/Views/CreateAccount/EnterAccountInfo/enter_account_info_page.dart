import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/Icons/icons.dart';
import 'package:ky_project/Commons/api_const.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/dialog_helper.dart';
import 'package:ky_project/Views/CreateAccount/EnterAccountInfo/enter_account_info_controller.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/WidgetCommon/checkbox_custom.dart';
import 'package:ky_project/Views/WidgetCommon/form_custom.dart';
import 'package:ky_project/Views/WidgetCommon/tooltip_custom.dart';

class EnterAccountInfoPage extends StatelessWidget {
  late EnterAccountInfoController controller;

  final double _dividerHeight = 5;
  final double _headerHeight = 60;

  EnterAccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(EnterAccountInfoController());

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
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color),
                onPressed: () => Get.back(),
              ),
              centerTitle: true,
              title: const Text(enterAccountInfoAppBarTitle),
            ),
            body: contentEnterAccountInfo,
          ),
        ],
      ),
    );
  }

  Widget get contentEnterAccountInfo {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _createForm,
              const SizedBox(height: 40),
              _createTermsOfService(constraints),
              _createCheckBox,
              const SizedBox(height: 10),
              _createButtonRegister,
            ],
          ),
        ),
      ),
    );
  }

  //create form
  Widget get _createForm {
    return FormCustom(
      formKey: controller.formKey,
      children: [
        const SizedBox(height: 50),
        TextFieldCustom(
          controller: controller.emailFilter,
          hintText: hntEmail,
          maxLength: emailMaxLength,
          validator: controller.emailValidate,
          label: lblEmail,
        ),
        TextFieldCustom(
          controller: controller.emailFilterConfirm,
          hintText: hntEmailConfirm,
          maxLength: emailMaxLength,
          validator: controller.emailConfirmValidate,
          label: lblEmailConfirm,
        ),
        const SizedBox(height: 100),
        TextFieldCustom(
          controller: controller.passwordFilter,
          hintText: hntPassword,
          maxLength: passwordMaxLength,
          obscureText: true,
          validator: controller.passwordValidate,
          labelChild: RichText(
            text: TextSpan(
              text: lblPassword,
              style: TextStyle(fontSize: 16, color: tPurple),
              children: <WidgetSpan>[
                WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.aboveBaseline,
                    child: TooltipCustom.standard(
                        Image.asset(bulbIcons), lblPasswordTooltip))
              ],
            ),
          ),
        ),
        TextFieldCustom(
          controller: controller.passwordConfirmFilter,
          hintText: hntPasswordConfirm,
          obscureText: true,
          maxLength: passwordMaxLength,
          validator: controller.passwordConfirmValidate,
          label: lblPasswordConfirm,
        ),
      ],
    );
  }

  //create Terms of Service
  Widget _createTermsOfService(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => DialogHelper.showDialogBottomSheet(_createContentPopup(
                constraints.maxHeight +
                    MediaQuery.of(Get.context!).viewInsets.bottom,
                lblTermsOfService,
                _webViewBuilder(urlTermsOfService))),
            child: const Text(lblTermsOfService,
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => DialogHelper.showDialogBottomSheet(_createContentPopup(
                constraints.maxHeight +
                    MediaQuery.of(Get.context!).viewInsets.bottom,
                lblPrivacyPolicy,
                _webViewBuilder(urlPrivacyPolicy))),
            child: const Text(lblPrivacyPolicy,
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  //create checkbox
  Widget get _createCheckBox {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: CheckboxCustom(
          onChanged: controller.checkBoxChange, title: lblAgreeCheckBox),
    );
  }

  //create button register
  Widget get _createButtonRegister {
    return Center(
      child: Obx(() => KyButton.standard(
            onPressed: controller.registerAccount,
            label: lblCreateAccountButton,
            style: !controller.enableButtonRequestLogin.value
                ? ButtonStandardStyle.purpleDisable
                : ButtonStandardStyle.purple,
          )),
    );
  }

  //create popup web-view
  Widget _createContentPopup(double popupHeight, String title, Widget child) {
    return Container(
      height: popupHeight,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          _headerPopup(title),
          Divider(
            height: _dividerHeight,
            color: Colors.black45,
            thickness: 1,
          ),
          SizedBox(
            height: popupHeight - _headerHeight - _dividerHeight,
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _headerPopup(String title) {
    return SizedBox(
      height: _headerHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          )
        ],
      ),
    );
  }

  Widget _webViewBuilder(String url) {
    return Builder(
      builder: (BuildContext context) {
        return InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
              javaScriptEnabled: true,
              horizontalScrollBarEnabled: false,
              verticalScrollBarEnabled: false,
              disableVerticalScroll: false,
            ),
            android: AndroidInAppWebViewOptions(
              builtInZoomControls: false,
              domStorageEnabled: true,
              displayZoomControls: false,
              useHybridComposition: true,
            ),
            ios: IOSInAppWebViewOptions(
                allowsBackForwardNavigationGestures: true,
                disableLongPressContextMenuOnLinks: true),
          ),
          onWebViewCreated: (InAppWebViewController webViewController) =>
              controller.inAppWebViewController = webViewController,
        );
      },
    );
  }
}
