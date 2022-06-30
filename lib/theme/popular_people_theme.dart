import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularPeopleTheme {
  static TextTheme appTextTheme = TextTheme(
    bodyText1: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyText2: const TextStyle(
        fontFamily: 'Avenir',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        height: 1.2),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: const TextStyle(
      fontSize: 20.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline4: GoogleFonts.dmSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      color: Colors.black,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static Color primary = Color.fromARGB(255, 42, 213, 184);
}
