import 'package:flutter/material.dart';

class Photo {
  int id;
  String thumbnailUrl;
  String fileName;
  String date;

  //local
  String? url;
  bool isSelected = false;
  Size box1 = const Size(0, 0);
  Size box2 = const Size(0, 0);

  //face
  FaceFeature? positionFace;
  FaceFeature? positionEye;
  FaceFeature? positionMouth;
  FaceFeature? positionNose;

  Photo({
    required this.id,
    required this.thumbnailUrl,
    this.url,
    required this.fileName,
    required this.date,
    this.isSelected = false,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      thumbnailUrl: json['thumbnail_url'],
      fileName: json['file_name'],
      date: json['date'],
      isSelected: false,
    );
  }
}

class FaceFeature {
  final Offset point;
  final double scale;
  final Size box1;
  final Size box2;

  FaceFeature(
      {required this.point,
      required this.scale,
      required this.box1,
      required this.box2});
}
