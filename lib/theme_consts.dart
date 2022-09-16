import 'package:flutter/material.dart';

class ThemeColors {
  static const mainThemeColor = Color.fromARGB(255, 243, 177, 78);
  static const mainTextColor = Colors.white;
}

class ThemeIcons {
  static const mainAppBarIcon = Icon(Icons.question_mark);
  static const draverClosingIcons = Icon(
    Icons.chevron_right,
    size: 30,
  );
}

class ThemeTexts {
  static const appBarText = Text(
    "Let's",
    style: TextStyle(
        color: ThemeColors.mainTextColor,
        fontSize: 45.0,
        fontStyle: FontStyle.italic),
  );
}

class ThemeLoginPageIcons {
  static const Icon nameIcon = Icon(Icons.people, size: 16);
  static const Icon passwordIcon = Icon(Icons.lock, size: 16);
}

class ThemeLoginPageTexts {
  static const String nameText = "Enter your name...";
  static const String passwordText = "Enter your password...";
}

class ThemeSignUpPage {
  static const String emailText = "Enter you email...";
  static const Icon emailIcon = Icon(Icons.email, size: 16);
}

class ThemeTextField extends InputDecorationTheme {
  ThemeTextField()
      : super(
          prefixIconColor: ThemeColors.mainTextColor,
          labelStyle: const TextStyle(color: ThemeColors.mainTextColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainTextColor)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainTextColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainTextColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: ThemeColors.mainTextColor)),
        );
}
