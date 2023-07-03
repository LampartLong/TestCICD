import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ky_project/Commons/Colors/colors.dart';

//Home screen
const appBarTheme =
    AppBarTheme(titleTextStyle: TextStyle(color: Colors.white, fontSize: 18));
final bottomNavigationBarThemeData = BottomNavigationBarThemeData(
  type: BottomNavigationBarType.fixed,
  selectedItemColor: tPurple,
  unselectedItemColor: Colors.black,
  selectedIconTheme: IconThemeData(color: tPurple, size: 18),
  unselectedIconTheme: const IconThemeData(color: Colors.black, size: 18),
  showUnselectedLabels: true,
  selectedLabelStyle:
      TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 10),
  unselectedLabelStyle:
      TextStyle(fontFamily: GoogleFonts.inter().fontFamily, fontSize: 10),
);
final listTileThemeData = ListTileThemeData(
    subtitleTextStyle: TextStyle(fontFamily: GoogleFonts.roboto().fontFamily));
