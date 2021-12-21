import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme(),
    scaffoldBackgroundColor: primaryColor,
    accentColor: secondaryColor.withOpacity(0.5),
    appBarTheme: AppBarTheme(elevation: 0.0, color: primaryColor, centerTitle: true, titleTextStyle: boldTextStyle(size: 20)),
    iconTheme: IconThemeData(color: Colors.white, size: 24),
    dividerColor: Colors.white54,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(secondaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
  );
}
