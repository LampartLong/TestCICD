import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:test_ci_cd/face_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_ci_cd/model/photo_model.dart';

class ViewerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TransformationController transformationController =
      TransformationController();
  late AnimationController animationController;
  Animation<Matrix4>? animationReset;

  Matrix4 finalMatrix = Matrix4.identity();

  final GlobalKey globalKey = GlobalKey();

  final Rx<Photo?> _photoA = Rx<Photo?>(null);
  Photo? get photoA => _photoA.value;
  set photoA(value) => _photoA.value = value;

  final _showBox = false.obs;
  bool get showBox => _showBox.value;
  set showBox(value) => _showBox.value = value;

  String url =
      // "https://s3-us-west-2.amazonaws.com/photoawardscom/uploads/84520/8-208834-21/full/3c48c289949e25f4a00e34d4938cc4dd.jpg";
      "https://www.mcall.com/wp-content/uploads/migration/2020/06/24/PPFK6BNC74276ABTWYVB44CYDI.jpg";
  // "https://www.northjersey.com/gcdn/presto/2018/09/01/PNJM/88ef77ce-806d-4442-9000-80be13cafd5c-001.JPG";
  // "https://i.pinimg.com/originals/54/60/4f/54604f7583f7c09b2d66e789dadfd1d8.jpg";
  // "https://images.unsplash.com/photo-1554651802-57f1d69a4944?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cG9ydHJhaXQlMjBmYWNlc3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80";
  // "https://images.iphonephotographyschool.com/28391/1120/Blur.jpg";

  late double width;
  late double height;

  final Duration delay = const Duration(milliseconds: 500);

  final _clickEnabled = true.obs;
  bool get clickEnabled => _clickEnabled.value;
  set clickEnabled(value) => _clickEnabled.value = value;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController.addListener(onAnimateReset);
    width = Get.width;
    // height = Get.height / 3 * 4;
    height = 741;

    photoA = Photo(
      id: 1,
      thumbnailUrl: "",
      fileName: "fileName28.jpg",
      date: "date",
      url: url,
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void onAnimateReset() {
    transformationController.value = finalMatrix = animationReset!.value;
  }

  Future<void> animateZoomToNosePosition() async {
    if (!clickEnabled) return;
    clickEnabled = false;
    showBox = false;
    // The translation values
    double transX = photoA!.positionNose!.point.dx;
    double transY = photoA!.positionNose!.point.dy;
    double scale = photoA!.positionNose!.scale;
    print("transX $transX");
    print("transY $transY");
    Matrix4 zoomedMatrix = Matrix4.identity()
      ..scale(scale)
      ..translate(-transX, -transY);

    animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: zoomedMatrix,
    ).animate(animationController);

    animationController.forward(from: 0.0);
    photoA!.box1 = photoA!.positionNose!.box1;
    photoA!.box2 = photoA!.positionNose!.box2;

    Future.delayed(delay, () {
      clickEnabled = true;
    });
  }

  Future<void> animateZoomToMouthPosition() async {
    if (!clickEnabled) return;
    clickEnabled = false;
    showBox = false;

    // The translation values
    double transX = photoA!.positionMouth!.point.dx;
    double transY = photoA!.positionMouth!.point.dy;
    double scale = photoA!.positionMouth!.scale;
    print("transX $transX");
    print("transY $transY");
    Matrix4 zoomedMatrix = Matrix4.identity()
      ..scale(scale)
      ..translate(-transX, -transY);

    animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: zoomedMatrix,
    ).animate(animationController);

    animationController.forward(from: 0.0);
    photoA!.box1 = photoA!.positionMouth!.box1;
    photoA!.box2 = photoA!.positionMouth!.box2;

    Future.delayed(delay, () {
      clickEnabled = true;
    });
  }

  Future<void> animateZoomToEyePosition() async {
    if (!clickEnabled) return;
    clickEnabled = false;
    showBox = false;

    double transX = photoA!.positionEye!.point.dx;
    double transY = photoA!.positionEye!.point.dy;
    double scale = photoA!.positionEye!.scale;
    print("transX $transX");
    print("transY $transY");

    Matrix4 zoomedMatrix = Matrix4.identity()
      ..scale(scale)
      ..translate(-transX, -transY);

    animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: zoomedMatrix,
    ).animate(animationController);

    animationController.forward(from: 0.0);
    photoA!.box1 = photoA!.positionEye!.box1;
    photoA!.box2 = photoA!.positionEye!.box2;

    Future.delayed(delay, () {
      clickEnabled = true;
    });
  }

  Future<void> animateZoomToFacePosition() async {
    if (!clickEnabled) return;
    clickEnabled = false;
    showBox = false;

    double transX = photoA!.positionFace!.point.dx;
    double transY = photoA!.positionFace!.point.dy;
    double scale = photoA!.positionFace!.scale;
    print("transX $transX");
    print("transY $transY");

    Matrix4 zoomedMatrix = Matrix4.identity()
      ..scale(scale)
      ..translate(-transX, -transY);

    animationReset = Matrix4Tween(
      begin: transformationController.value,
      end: zoomedMatrix,
    ).animate(animationController);

    animationController.forward(from: 0.0);
    photoA!.box1 = photoA!.positionFace!.box1;
    photoA!.box2 = photoA!.positionFace!.box2;

    Future.delayed(delay, () {
      clickEnabled = true;
    });
  }

  Future<void> capturePng() async {
    try {
      String fileName = photoA!.fileName;

      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final file = await saveImage(fileName, pngBytes);
      await FaceHelper.detectFaces(fileName, file, photoA!, width, height);

      print("detectFaces ${DateTime.now()}");
    } catch (e) {
      print(e);
    }
  }

  Future<File> saveImage(String fileName, Uint8List bytes) async {
    Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/$fileName');
    return await file.writeAsBytes(bytes);
  }
}
