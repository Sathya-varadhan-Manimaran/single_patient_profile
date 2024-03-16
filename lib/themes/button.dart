import 'package:flutter/material.dart';
import 'package:single_patient_profile/themes/colors.dart';

class ProfileButton {
  static ButtonStyle optionButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(ProfileColors.button),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(
            color: ProfileColors.text, style: BorderStyle.none),
      ),
    ),
  );
}
