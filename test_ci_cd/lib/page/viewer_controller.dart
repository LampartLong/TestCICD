import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewerController extends GetxController with SingleGetTickerProviderMixin {
  final TransformationController transformationController = TransformationController();
  late AnimationController animationController;
  Animation<Matrix4>? animationReset;

  Matrix4 finalMatrix = Matrix4.identity();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animationController.addListener(onAnimateReset);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void onAnimateReset() {
    transformationController.value = finalMatrix = animationReset!.value;
  }

  void animateZoomToPosition() {
    Matrix4 zoomedMatrix = Matrix4.identity()
      ..scale(2.5)
      ..translate(0.0, -100.0);

    animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: zoomedMatrix,
    ).animate(animationController);

    animationController.forward(from: 0.0);
  }
}
