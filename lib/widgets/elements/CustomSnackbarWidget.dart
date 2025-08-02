import 'package:flutter/material.dart';

void CustomSnackbarWidget({
  required BuildContext context,
  String title = "Something went wrong",
  Color backgroundColor = Colors.red,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    ),
  );
}
