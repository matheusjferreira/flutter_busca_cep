import 'package:flutter/material.dart';

enum AppTheme {
  darkTheme,
  lightTheme,
}

extension AppThemeExtension on AppTheme {
  ThemeData get getTheme {
    switch (this) {
      case AppTheme.darkTheme:
        return ThemeData.dark().copyWith(
          colorScheme:
              const ColorScheme.dark().copyWith(primary: Colors.orange),
        );
      case AppTheme.lightTheme:
        return ThemeData.light().copyWith(
          colorScheme:
              const ColorScheme.light().copyWith(primary: Colors.orange),
        );
    }
  }
}
