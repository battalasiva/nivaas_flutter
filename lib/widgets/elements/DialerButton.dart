import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:url_launcher/url_launcher.dart';

class DialerButton extends StatelessWidget {
  final String phoneNumber;

  const DialerButton({super.key, required this.phoneNumber});

  launchDialer() async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch dialer with phone number $phoneNumber';
      }
    } catch (e) {
      print('Error launching dialer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchDialer();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.blue,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            caller,
            fit: BoxFit.contain,
            color: null,
          ),
        ),
      ),
    );
  }
}
