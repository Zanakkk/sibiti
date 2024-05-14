// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ZanakColors {
  ZanakColors._(); // this basically makes it so you can instantiate this class

  static const MaterialColor blue = MaterialColor(
    _blue,
    <int, Color>{
      100: Color(0xFF03045e),
      200: Color(0xFF023e8a),
      300: Color(0xFF0077b6),
      400: Color(0xFF0096c7),
      500: Color(_blue),
      600: Color(0xFF48cae4),
      700: Color(0xFF90e0ef),
      800: Color(0xFFade8f4),
      900: Color(0xFFcaf0f8),
    },
  );
  static const int _blue = 0xFF0077b6;
}
