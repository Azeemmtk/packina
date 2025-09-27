import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packina/core/constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: mainColor,
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.robotoTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: const Color(0xFF616161), // <-- Set default text color
      displayColor: const Color(0xFF616161),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: mainColor,
    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: GoogleFonts.robotoTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
