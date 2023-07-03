import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

final backgroundLinearGradient = [
  HexColor.fromHex("#5C5C68"),
  HexColor.fromHex("#848490"),
  HexColor.fromHex("#C2C2CF"),
  HexColor.fromHex("#EEEEFB"),
  HexColor.fromHex("#B9B9C6"),
  HexColor.fromHex("#92929F"),
];

final backgroundSilverLinearGradient = [
  HexColor.fromHex("#EEF2EF"),
  HexColor.fromHex("#9FA9A9"),
  HexColor.fromHex("#E3EDED"),
  HexColor.fromHex("#B5B9AA"),
  HexColor.fromHex("#EBF0EC"),
];

final backgroundPinkYellowLinearGradient = [
  HexColor.fromHex("#FF80A4"),
  HexColor.fromHex("#FF8471"),
  HexColor.fromHex("#FF9784"),
  HexColor.fromHex("#FF907D"),
  HexColor.fromHex("#FFC480"),
];

final backgroundOrangeLinearGradient = [
  HexColor.fromHex("#FAB588"),
  HexColor.fromHex("#F37856"),
];

final backgroundOrangeLightLinearGradient = [
  HexColor.fromHex("#F3B397"),
  HexColor.fromHex("#F1E5E2"),
];

final backgroundPinkLinearGradient = [
  HexColor.fromHex("#E395A3"),
  HexColor.fromHex("#F6B4C1"),
  HexColor.fromHex("#E395A3"),
];

final buttonLinearGradient = [
  HexColor.fromHex("#FF80A4"),
  HexColor.fromHex("#FF8471"),
  HexColor.fromHex("#FF9784"),
  HexColor.fromHex("#FF907D"),
  HexColor.fromHex("#FFC480"),
];

//Text colors
const tBlack = Colors.black;
const tWhite = Colors.white;
final tGrey = HexColor.fromHex("#979C9E");
final tRed = HexColor.fromHex("#FF0000");
final tError = HexColor.fromHex("#FF5247");
final tBlue = HexColor.fromHex("#0000FF");
final tPurple = HexColor.fromHex("#6565D9");
final tCalendarCretanGreen = HexColor.fromHex("#91CCD8");
final tCalendarMelon = HexColor.fromHex("#FF7759");
final tCalendarBlue = HexColor.fromHex("#85BACB");
final tCalendarPink = HexColor.fromHex("#EBB293");
final tCalendarGreen = HexColor.fromHex("#8BCB85");

//Icon colors
const iBlack = Colors.black;
const iWhite = Colors.white;
final iGrey = HexColor.fromHex("#979C9E");
final iPurple = HexColor.fromHex("#6750A4");

//Button colors
final bGrey = HexColor.fromHex("#E3E5E5");
final bPurpleDefault = HexColor.fromHex("#8585CB");
final bPurpleHover = HexColor.fromHex("#AFAFE1");
final bPurpleDisable = HexColor.fromHex("#D0D0E7");
final bPinkSecondary = HexColor.fromHex("#F0506E");
final bPinkDisable = HexColor.fromHex("#F6DFE3");
final bBlueGradient = HexColor.fromHex("#81DBED");
final bBlueGradientDisable = HexColor.fromHex("#C0E1E8");

//Background color
final bgGreenAccent = HexColor.fromHex("#57C5B6");

final lineCalendar = HexColor.fromHex("#BCBCBC");


