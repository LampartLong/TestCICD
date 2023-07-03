import 'dart:ui';
import 'package:flutter/material.dart';

class ClipRRectBlur extends StatelessWidget {
  const ClipRRectBlur(
      {super.key, required this.child, this.width, this.height});

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 10,
          ),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(20),
            color: Colors.white.withOpacity(0.2),
            child: child,
          ),
        ),
      ),
    );
  }
}
