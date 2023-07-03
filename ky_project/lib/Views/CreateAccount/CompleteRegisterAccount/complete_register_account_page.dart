import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/Colors/colors.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:ky_project/Views/WidgetCommon/button_custom.dart';
import 'package:ky_project/Views/CreateAccount/CompleteRegisterAccount/complete_register_account_controller.dart';

class CompleteRegisterAccountPage extends StatelessWidget {
  late CompleteRegisterAccountController controller;

  CompleteRegisterAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(CompleteRegisterAccountController());

    return WillPopScope(
      onWillPop: () async {
        return false;
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
                  tileMode: TileMode.mirror,
                  transform: const GradientRotation(math.pi / 4.3),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(completeRegisterAccountAppBarTitle,
                  style: TextStyle(color: Colors.white)),
            ),
            body: SizedBox(
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(lblCreateAccountSuccess),
                  KyButton.standard(
                    onPressed: () {
                      Get.until((route) => route.settings.name == AppRoutes.login);
                    },
                    label: lblTopBack,
                    style: ButtonStandardStyle.purple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
