import 'package:flutter/material.dart';

class PinValue {
  final FocusNode focusNode;
  final TextEditingController controller;
  PinValue()
      : focusNode = FocusNode(),
        controller = TextEditingController();
}
