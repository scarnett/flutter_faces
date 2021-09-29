import 'package:flutter/material.dart';

extension StringExtension on String {
  Color toColor() =>
      Color(int.parse(this.substring(1, 7), radix: 16) + 0xFF000000);
}
