import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex() => '#${this.value.toRadixString(16).substring(2, 8)}';
}
