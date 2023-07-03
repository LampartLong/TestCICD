import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TooltipCustom extends StatelessWidget {
  final Widget child;
  final String message;
  final TextStyle? messageStyle;
  final Color? backgroundColor;
  final Gradient? gradient;

  const TooltipCustom(
      {super.key,
      required this.child,
      required this.message,
      this.backgroundColor = Colors.white,
      this.gradient,
      this.messageStyle});

  factory TooltipCustom.standard(Widget child, String message,
      {Key? key,
      Color backgroundColor = Colors.white,
      TextStyle? messageStyle}) {
    return TooltipCustom(
      message: message,
      backgroundColor: backgroundColor,
      messageStyle:
          messageStyle ?? Get.context!.textTheme.labelSmall?.copyWith(),
      child: child,
    );
  }

  factory TooltipCustom.gradient(
      Widget child, String message, Gradient gradient,
      {Key? key, TextStyle? messageStyle}) {
    return TooltipCustom(
      message: message,
      gradient: gradient,
      messageStyle: messageStyle ??
          Get.context!.textTheme.labelSmall?.copyWith(color: Colors.white),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var decoration = ShapeDecoration(
        color: backgroundColor, shape: const ToolTipCustomShape());

    if (gradient != null) {
      decoration = ShapeDecoration(
        shape: const ToolTipCustomShape(),
        gradient: gradient,
      );
    }

    return Tooltip(
      richMessage: TextSpan(children: <InlineSpan>[
        WidgetSpan(
            child: Container(
          constraints: BoxConstraints(maxWidth: Get.context!.width * 0.55),
          child: Text(message, style: messageStyle),
        ))
      ]),
      triggerMode: TooltipTriggerMode.tap,
      showDuration: const Duration(seconds: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: decoration,
      child: child,
    );
  }
}

class ToolTipCustomShape extends ShapeBorder {
  const ToolTipCustomShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)))
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
