import 'package:flutter/material.dart';

class ColorConstant {
  static Color theame = fromHex('#c6ba4d');
  static Color black = Colors.black;
  static Color botton = Colors.blue;
  static Color lightblack = Color(0xFF7A7A7A);
  static Color white = Colors.white;
  static Color backgraund = Color(0xFFFFFFFF);
  static Color transparent = Colors.transparent;
  static Color skip = Color(0xFF123456);
  static Color productdesign = Color(0xFF2969FF);
  static Color white24 = Colors.white24;
  static Color white70 = Colors.white70;
  static Color white12 = Colors.black12;
  static Color backgroundColor = Color(0xFF121A26);
  static Color appliedbuttonback = Color(0xFFE5F2FB);
  static Color appliedbuttonText = Colors.blue;
  static Color backgroundColorreviewed = Color(0xFFFFF4E9);
  static Color backgroundColorreviewedtext = Color(0xFFFF9027);
  static Color backcolointerview = Color(0xFFEBFAEF);
  static Color backcolointerviewtext = Color(0xFF03C238);
  static Color backcolorreject = Color(0xFFFFF1ED);
  static Color backcolorrejecttext = Color(0xFFFF2720);
  static Color bordercolor = Color(0xFFE2E8F0);
  static Color scalecolor = Color.fromARGB(255, 115, 179, 243);
  static Color green = Colors.green;
  static Color arrow = Color(0xFF7A7A7A);
  static const iconbg = Color(0xFFF5F5F5);

  static const Color primaryColor = Color(0xFFFF9027);
  static const Color accentColor = Color(0xffFF4E00);
  static const Color orangeGradientEnd = Color(0xfffc4a1a);
  static const Color orangeGradientStart = Color(0xfff7b733);
  static const Color themeGradientStart = Color(0xFF62B6B7);
  static const Color themeGradientEnd = Color(0xFF97DECE);
  static const Color precentage = Color(0xFFE5F2FB);
  static Color red = Colors.red;
  static Color loginemail = Color(0xFF7A7A7A);
  static Color lightBackground = Color(0xFFF1F1F1);

  static const Color category = Color(0xFF666E7A);
  static const Color editinfo = Color(0xFF2969FF);
  static const Color settingback = Color.fromARGB(255, 235, 239, 244);
  static Color namebg = fromHex("#ffffff");
  static const Color settingborder = Color(0xFFE8E9F8);

  static const LinearGradient appBarGradient =
      LinearGradient(colors: [themeGradientStart, themeGradientEnd]);

  static const bootombar = Color(0xFFB5B5B5);

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
