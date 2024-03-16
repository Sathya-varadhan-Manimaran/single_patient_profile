import 'package:flutter/material.dart';
import 'package:single_patient_profile/themes/colors.dart';

class ProfileFont {
  static String profileFont = 'Nunito';
  static String profileAppName = 'EastSeaDokdo';
  static String profileGreeting = 'Stick';
}

class ProfileText {
  static TextStyle titleAppName = TextStyle(
    fontSize: 40,
    color: ProfileColors.textSecondary,
    fontWeight: FontWeight.w500,
    fontFamily: ProfileFont.profileAppName,
  );

  static TextStyle titleScaffold = TextStyle(
    fontSize: 24,
    color: ProfileColors.textSecondary,
    fontWeight: FontWeight.w900,
    fontFamily: ProfileFont.profileFont,
  );

  static TextStyle titleCard = TextStyle(
    fontSize: 20,
    color: ProfileColors.background,
    fontWeight: FontWeight.w900,
    fontFamily: ProfileFont.profileFont,
  );

  static TextStyle fieldTitle = TextStyle(
    fontSize: 18,
    color: ProfileColors.text,
    fontWeight: FontWeight.w700,
    fontFamily: ProfileFont.profileFont,
  );

  static TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: ProfileColors.text,
    fontWeight: FontWeight.normal,
    fontFamily: ProfileFont.profileFont,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 20,
    color: ProfileColors.textSecondary,
    fontWeight: FontWeight.w900,
    fontFamily: ProfileFont.profileFont,
  );

  static TextStyle greetingText = TextStyle(
    fontSize: 28,
    color: ProfileColors.textSecondary,
    fontWeight: FontWeight.w500,
    fontFamily: ProfileFont.profileGreeting,
  );
}
