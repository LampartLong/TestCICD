import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:test_ci_cd/app_const.dart';
import 'package:test_ci_cd/model/photo_model.dart';

class FaceHelper {
  // Global mapping of face type to the corresponding file path
  static final Map<int, String> typeToFilePath = {
    comparePhotoMouthType: '/mouth_cropped_',
    comparePhotoFaceType: '/face_cropped_',
    comparePhotoEyeType: '/eye_cropped_',
    comparePhotoNoseType: '/nose_cropped_',
  };

// Global mapping of face type to the corresponding landmarks
  static final Map<int, List<FaceLandmarkType>> typeToLandmark = {
    comparePhotoMouthType: [
      FaceLandmarkType.leftMouth,
      FaceLandmarkType.rightMouth,
      FaceLandmarkType.bottomMouth,
    ],
    comparePhotoFaceType: [],
    comparePhotoEyeType: [
      FaceLandmarkType.leftEye,
      FaceLandmarkType.rightEye,
    ],
    comparePhotoNoseType: [
      FaceLandmarkType.noseBase,
    ],
  };

  static Future<String> getFilePathFacial(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    return "${tempDir.path}/$fileName";
  }

  static Future<File> downloadImageFromUrl(String fileName, String url) async {
    String filePath = await getFilePathFacial(fileName);
    File file = File(filePath);
    if (file.existsSync()) {
      return file;
    }
    Response response = await get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  static detectFaces(String fileName, File file, Photo photo, double width,
      double height) async {
    final inputImage = InputImage.fromFile(file);

    final faceDetectorOptions = FaceDetectorOptions(
      enableClassification: false,
      enableLandmarks: true,
      enableContours: false,
      enableTracking: false,
    );

    final faceDetector = GoogleMlKit.vision.faceDetector(faceDetectorOptions);
    List<Face> faces;
    try {
      faces = await faceDetector.processImage(inputImage);
      print("faceDetector ${DateTime.now()}");
    } catch (e) {
      // Handle face detection problem
      print('Face detection failed: $e');
      return;
    }
    if (faces.isEmpty) {
      return;
    }
    Face face = faces.first;

    img.Image? image = img.decodeImage(file.readAsBytesSync());
    print("readAsBytesSync ${DateTime.now()}");
    print("image ${image?.width} ${image?.height}");

    if (image != null) {
      // Mouth
      final leftMouth = face.landmarks[FaceLandmarkType.leftMouth];
      final rightMouth = face.landmarks[FaceLandmarkType.rightMouth];
      final bottomMouth = face.landmarks[FaceLandmarkType.bottomMouth];

      if (leftMouth != null && rightMouth != null && bottomMouth != null) {
        Offset leftMouthOffset = Offset(
            leftMouth.position.x.toDouble(), leftMouth.position.y.toDouble());
        Offset rightMouthOffset = Offset(
            rightMouth.position.x.toDouble(), rightMouth.position.y.toDouble());
        Offset bottomMouthOffset = Offset(bottomMouth.position.x.toDouble(),
            bottomMouth.position.y.toDouble());

        await cropImageAtMouthPosition(fileName, image, leftMouthOffset,
            rightMouthOffset, bottomMouthOffset, photo, width, height);

        // Face
        if (faces.isNotEmpty) {
          Rect faceBoundingBox = faces.first.boundingBox;
          await cropImageAtFacePosition(
              fileName, image, faceBoundingBox, photo, width, height);
        }

        // Eye
        final leftEye = face.landmarks[FaceLandmarkType.leftEye];
        final rightEye = face.landmarks[FaceLandmarkType.rightEye];

        if (leftEye != null && rightEye != null) {
          Offset leftEyeOffset = Offset(
              leftEye.position.x.toDouble(), leftEye.position.y.toDouble());
          Offset rightEyeOffset = Offset(
              rightEye.position.x.toDouble(), rightEye.position.y.toDouble());

          await cropImageAtEyePosition(fileName, image, leftEyeOffset,
              rightEyeOffset, photo, width, height);
        }

        // Nose
        final noseBase = face.landmarks[FaceLandmarkType.noseBase];

        if (noseBase != null) {
          Offset noseBaseOffset = Offset(
              noseBase.position.x.toDouble(), noseBase.position.y.toDouble());
          await cropImageAtNosePosition(
              fileName, image, noseBaseOffset, photo, width, height);
        }
      }
    }
  }

  static cropImageAtFacePosition(
    String fileName,
    img.Image image,
    Rect faceBoundingBox,
    Photo photo,
    double width,
    double height,
  ) async {
    int x = faceBoundingBox.left.round();
    int y = faceBoundingBox.top.round();
    int faceWidth = faceBoundingBox.width.round();
    int faceHeight = faceBoundingBox.height.round();
    print(
        "x $x y $y width $width height $height faceWidth $faceWidth faceHeight $faceHeight");
    double scaleWidth = width / faceWidth;
    double scaleHeight = height / faceHeight;
    double scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;

    double transX = 0;
    double transY = 0;
    print("scale $scale $scaleWidth $scaleHeight");
    if (scale < 1) {
      scale = 1;
    } else {
      transX = x - ((width - (faceWidth * scale)) / (2 * scale));
      print("transX $transX");

      if (transX < 0) {
        transX = 0;
      } else if (transX * scale > width) {
        transX = width / scale;
      }
      transY = y - ((height - (faceHeight * scale)) / (2 * scale));
      // transY = 165.0;
      print("transY $transY");

      if (transY < 0) {
        transY = 0;
      } else if (transY * scale > height) {
        transY = height / scale;
      }
    }
    print("transX $transX");
    print("transY $transY");

    FaceFeature faceFeature = FaceFeature(
        point: Offset(transX, transY),
        scale: scale,
        box1: const Size(0, 0),
        box2: const Size(0, 0));

    photo.positionFace = faceFeature;
    photo.box1 = const Size(0, 0);
    photo.box2 = const Size(0, 0);
    print("cropImageAtFacePosition");
    print("x $x y $y width $width height $height");
  }

  static cropImageAtNosePosition(
    String fileName,
    img.Image image,
    Offset noseBase,
    Photo photo,
    double width,
    double height,
  ) async {
    print(
        "noseBase ${noseBase.dx} y ${noseBase.dy} ${noseBase.distance} ${noseBase.distanceSquared}");

    double transX = noseBase.dx - width / 4;
    print("transX $transX");
    if (transX < 0) {
      transX = 0;
    } else if (transX * 2 > width) {
      transX = width / 2;
    }
    double transY = noseBase.dy - height / 4;
    print("transY $transY");
    if (transY < 0) {
      transY = 0;
    } else if (transY * 2 > height) {
      transY = height / 2;
    }

    print("transX $transX");
    print("transY $transY");

    FaceFeature faceFeature = FaceFeature(
        point: Offset(transX, transY),
        scale: 2,
        box1: Size(0, height / 5),
        box2: Size(0, height / 2.5));

    photo.positionNose = faceFeature;

    print("cropImageAtNosePosition");
    print("x ${noseBase.dx} y ${noseBase.dy}");
  }

  static cropImageAtMouthPosition(
      String fileName,
      img.Image image,
      Offset leftMouthPosition,
      Offset rightMouthPosition,
      Offset bottomMouthPosition,
      Photo photo,
      double width,
      double height) async {
    double transX = bottomMouthPosition.dx - width / 4;
    if (transX < 0) {
      transX = 0;
    } else if (transX * 2 > width) {
      transX = width / 2;
    }
    double transY = bottomMouthPosition.dy - height / 4;
    if (transY < 0) {
      transY = 0;
    } else if (transY * 2 > height) {
      transY = height / 2;
    }

    print("transX $transX");
    print("transY $transY");

    FaceFeature faceFeature = FaceFeature(
        point: Offset(transX, transY),
        scale: 2,
        box1: Size(0, height / 3),
        box2: Size(0, height / 3));

    photo.positionMouth = faceFeature;

    print("cropImageAtMouthPosition");
    print(
        "leftMouthPosition ${leftMouthPosition.dx} y ${leftMouthPosition.dy}");
    print(
        "rightMouthPosition ${rightMouthPosition.dx} y ${rightMouthPosition.dy}");
    print(
        "bottomMouthPosition ${bottomMouthPosition.dx} y ${bottomMouthPosition.dy}");
  }

  static cropImageAtEyePosition(
      String fileName,
      img.Image image,
      Offset leftEyePosition,
      Offset rightEyePosition,
      Photo photo,
      double width,
      double height) async {
    double scaleWidth =
        width / (rightEyePosition.dx - leftEyePosition.dx).abs();
    double scaleHeight =
        height / (rightEyePosition.dy - leftEyePosition.dy).abs();
    double scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
    scale = scale / 2;

    double transX =
        (leftEyePosition.dx + rightEyePosition.dx) / 2 - width / (2 * scale);

    double maxTransX = (width * scale - width) / scale;
    if (transX > maxTransX) {
      transX = maxTransX;
    } else if (transX < 0) {
      transX = 0;
    }

    double maxTransY = (height * scale - height) / scale;
    double transY =
        (leftEyePosition.dy + rightEyePosition.dy) / 2 - height / (2 * scale);

    if (transY > maxTransY) {
      transY = maxTransY;
    } else if (transY < 0) {
      transY = 0;
    }

    FaceFeature faceFeature = FaceFeature(
        point: Offset(transX, transY),
        scale: scale,
        box1: Size(0, height / 2.5),
        box2: Size(0, height / 2.5));

    photo.positionEye = faceFeature;

    print("cropImageAtEyePosition");
    print("leftEyePosition ${leftEyePosition.dx} y ${leftEyePosition.dy}");
    print("rightEyePosition ${rightEyePosition.dx} y ${rightEyePosition.dy}");
  }
}
