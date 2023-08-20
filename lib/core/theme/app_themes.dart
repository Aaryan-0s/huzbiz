import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static getApplicationTheme() {
    return ThemeData(
      useMaterial3: true,
    );
  }
}
