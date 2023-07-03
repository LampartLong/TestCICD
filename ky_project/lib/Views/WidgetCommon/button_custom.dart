import 'package:flutter/material.dart';
import 'package:ky_project/Commons/Colors/colors.dart';

class KyButton extends ElevatedButton {
  const KyButton({
    super.key,
    required super.onPressed,
    required super.child,
    super.onLongPress,
    super.style,
  });

  factory KyButton.standard({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    String? icon,
    ButtonStandardStyle? style,
    IconButtonAlignment? iconAlign,
  }) {
    return KyButton(
        onPressed: onPressed,
        style: _getStandardButtonStyle(style!),
        child: _ElevatedButtonWithIconChild(
            label: Text(label, style: _getStandardButtonTextStyle(style)),
            icon: (icon != null)
                ? Image.asset(icon!,
                    width: 18,
                    height: 18,
                    color: _getStandardButtonTextStyle(style!).color)
                : const SizedBox(width: 10),
            align: iconAlign ?? IconButtonAlignment.center));
  }

  static ButtonStyle _getStandardButtonStyle(ButtonStandardStyle style) {
    ButtonStyle resultStyle;

    switch (style) {
      case ButtonStandardStyle.black:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.white:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.transparent:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.pink:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPinkSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.pinkDisable:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPinkDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.purple:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPurpleDefault,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      case ButtonStandardStyle.purpleDisable:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPurpleDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        );
        break;
      default:
        resultStyle = ElevatedButton.styleFrom();
        break;
    }

    return resultStyle;
  }

  static TextStyle _getStandardButtonTextStyle(ButtonStandardStyle style) {
    TextStyle resultStyle;

    switch (style) {
      case ButtonStandardStyle.white:
        resultStyle = const TextStyle(color: Colors.black, fontSize: 16);
        break;
      case ButtonStandardStyle.transparent:
        resultStyle = TextStyle(color: tGrey, fontSize: 16);
        break;
      default:
        resultStyle = const TextStyle(color: Colors.white, fontSize: 16);
        break;
    }

    return resultStyle;
  }

  factory KyButton.square({
    Key? key,
    required VoidCallback? onPressed,
    required String label,
    required String icon,
    ButtonSquareStyle? style,
  }) {
    return KyButton(
        onPressed: onPressed,
        style: _getSquareButtonStyle(style!),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon,
                width: 18,
                height: 18,
                color: _getSquareButtonTextStyle(style!).color),
            const SizedBox(height: 5),
            Flexible(
              child: Text(label, style: _getSquareButtonTextStyle(style)),
            )
          ],
        ));
  }

  static ButtonStyle _getSquareButtonStyle(ButtonSquareStyle style) {
    ButtonStyle resultStyle;

    switch (style) {
      case ButtonSquareStyle.white:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.blueGradient:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bBlueGradient,
          elevation: 0,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.blueGradientDisable:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bBlueGradientDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.pink:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPinkSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.pinkDisable:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPinkDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.purple:
        resultStyle = ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          backgroundColor: bPurpleDefault,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      case ButtonSquareStyle.purpleDisable:
        resultStyle = ElevatedButton.styleFrom(
          backgroundColor: bPurpleDisable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
        break;
      default:
        resultStyle = ElevatedButton.styleFrom();
        break;
    }

    return resultStyle;
  }

  static TextStyle _getSquareButtonTextStyle(ButtonSquareStyle style) {
    TextStyle resultStyle;

    switch (style) {
      case ButtonSquareStyle.white:
        resultStyle = const TextStyle(color: Colors.black, fontSize: 10);
        break;
      default:
        resultStyle = const TextStyle(color: Colors.white, fontSize: 10);
        break;
    }

    return resultStyle;
  }

  factory KyButton.small({
    Key? key,
    required VoidCallback? onPressed,
    required Widget label,
    Widget? icon,
    ButtonStyle? style,
  }) {
    return KyButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? const SizedBox(width: 0),
            const SizedBox(width: 5),
            Flexible(child: label)
          ],
        ));
  }

  static text({
    Key? key,
    required VoidCallback? onPressed,
    required Text label,
  }) {
    return InkWell(
      key: key,
      onTap: onPressed,
      child: label,
    );
  }
}

class _ElevatedButtonWithIconChild extends StatelessWidget {
  _ElevatedButtonWithIconChild(
      {required this.label, required Widget icon, align}) {
    _icon = icon;
    _align = align;
  }

  final Widget label;
  late Widget _icon;
  late IconButtonAlignment _align;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Flexible(child: label)];
    MainAxisSize position = MainAxisSize.max;

    switch (_align) {
      case IconButtonAlignment.right:
        children.insert(0, const SizedBox(width: 10));
        children.add(_icon);
        break;
      default:
        children.insert(0, _icon);
        children.add(const SizedBox(width: 10));
        break;
    }

    if (_align == IconButtonAlignment.center) {
      position = MainAxisSize.min;
    }

    return Row(
      mainAxisSize: position,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}

enum IconButtonAlignment {
  left,
  center,
  right,
}

enum ButtonStandardStyle {
  black,
  white,
  transparent,
  pink,
  pinkDisable,
  purple,
  purpleDisable,
}

enum ButtonSquareStyle {
  white,
  blueGradient,
  blueGradientDisable,
  pink,
  pinkDisable,
  purple,
  purpleDisable,
}
