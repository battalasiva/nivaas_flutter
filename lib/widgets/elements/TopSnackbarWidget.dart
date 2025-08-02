import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopSnackbarWidget {
  static void showTopSnackbar({
    required BuildContext context,
    String title = "Default Title",
    String message = "Default Message",
    Color backgroundColor = Colors.blue,
  }) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        backgroundColor: backgroundColor,
        message: message,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        iconPositionLeft: -100,
      ),
      displayDuration: const Duration(seconds: 2),
    );
  }
}
