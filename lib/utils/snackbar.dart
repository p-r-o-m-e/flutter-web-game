import "package:flutter/material.dart";

class SnackBarTool {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        // duration: Duration(seconds: 2),
      ),
    );
  }
}
