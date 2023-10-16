import 'package:flutter/material.dart';

class SnackBarWidget {
  static void show(BuildContext context,
      {required String message, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
