import 'package:flutter/material.dart';
import 'package:single_patient_profile/themes/colors.dart';

class ProfileCalendar {
  static ColorScheme calendarColorScheme = const ColorScheme.light(
    primary: ProfileColors.background, // header background color
    onPrimary: ProfileColors.secondary, // header text color
    onSurface: ProfileColors.text,
  );

  static TextButtonThemeData calendarTextButtonTheme = TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: ProfileColors.background));
}
