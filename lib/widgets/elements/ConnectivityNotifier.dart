import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class NetworkCheckService {
  StreamSubscription<InternetConnectionStatus>? _subscription;

  void startMonitoring(BuildContext context) {
    _subscription = InternetConnectionChecker.createInstance().onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.disconnected) {
          // Show Snackbar when disconnected
          CustomSnackbarWidget(
            context: context,
            title: 'No internet connection. Please try again.',
            backgroundColor: AppColor.red,
          );
        } else if (status == InternetConnectionStatus.connected) {
          // Show Snackbar when connected
          CustomSnackbarWidget(
            context: context,
            title: 'Back online!',
            backgroundColor: AppColor.green,
          );
        }
      },
    );
  }

  void stopMonitoring() {
    _subscription?.cancel();
  }
}
