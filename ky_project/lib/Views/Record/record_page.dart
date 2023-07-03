import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/app_const.dart';
import 'package:ky_project/Views/Record/record_controller.dart';

class RecordPage extends StatelessWidget {
  late RecordController recordController;

  @override
  Widget build(BuildContext context) {
    recordController = Get.find<RecordController>();
    return const Center(
      child: Text(
        'Index 3: $lblRecord',
      ),
    );
  }
}
