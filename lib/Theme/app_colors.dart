import 'package:flutter/material.dart';

class AppColors {
  static Color _colorFromHex(String hexColor) {
    final color = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$color', radix: 16));
  }

  static Color _colorOpacity20FromHex(String hexColor) {
    final color = hexColor.replaceAll('#', '');
    return Color(int.parse('33$color', radix: 16));
  }

  // * color App

  static Color mainColor = _colorFromHex('#0d3f7a');
  static Color secondaryColor = _colorFromHex('#b7bdc4');

  static Color blackColor = _colorFromHex('#000000');
  static Color formHintTextColor = _colorFromHex('#DFE0DF');
  static Color borderColor = _colorFromHex('##D9DBDB');
  static Color hintColor = _colorFromHex('#808080');
  static Color white = _colorFromHex('#FFFFFF');
  static Color formBorderColor = _colorFromHex("#CCCCCC");
  static Color formFillColor = _colorOpacity20FromHex("#FFFFFF");
  static Color errorColor = _colorFromHex("#D70404");
}
