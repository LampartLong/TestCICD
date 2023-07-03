import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Helpers/permissions_helper.dart';
import 'package:ky_project/Views/Login/login_controller.dart';

class LoadingPage extends StatelessWidget {
  late LoginController controller;

  LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    PermissionHelper.requestPermissions();
    controller = Get.put(LoginController());
    controller.autoLogin();

    return const Scaffold(
      body: Center(),
    );
  }
}
