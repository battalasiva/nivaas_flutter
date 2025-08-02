import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/coins-subscription/subscription/subscription.dart';

class AlertMessages extends StatelessWidget {
  final DateTime currentDate;
  final DateTime endDate;
  final int? apartmentId,userId;
  final String? apartmentName, mobileNumber, email;

  const AlertMessages({
    super.key,
    required this.currentDate,
    required this.endDate,
    this.apartmentId,
    this.apartmentName,
    this.userId,
    this.mobileNumber,
    this.email,
  });

  String getFormattedDate(DateTime endDate) {
    final difference = endDate.difference(currentDate).inDays;
    print('DIFF : $difference');
    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Tomorrow";
    } else if (difference == -1) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMM yyyy').format(endDate);
    }
  }

  String getMessage(DateTime endDate) {
    final difference = endDate.difference(currentDate).inDays;
    if (difference == 0 || difference == 1) {
      return "Your subscription is expiring ";
    } else if (difference == -1) {
      return "Your subscription was expired ";
    } else if (difference < -2) {
      return "Your subscription was expired on ";
    } else if (difference > 1) {
      return "Your subscription is expiring on ";
    } else {
      return "Your subscription was expired on ";
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isExpiringOrActive = currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColor.blueShade,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.greyBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: isExpiringOrActive ? AppColor.orange : AppColor.red,
                  size: 27,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${getMessage(endDate)} ",
                                style: txt_12_400.copyWith(color: AppColor.black1),
                              ),
                              TextSpan(
                                text: getFormattedDate(endDate),
                                style: txt_13_600.copyWith(color: AppColor.black1),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Subscription(apartmentId: apartmentId,
                                        apartmentName: apartmentName,
                                        userId: userId,
                                        mobileNumber: mobileNumber,
                                        email: email),
                                  ),
                                );
                              },
                              child: Text(
                                "Click Here",
                                style: txt_12_400.copyWith(
                                  color: AppColor.blue,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              " to renew subscription",
                              style: txt_12_400.copyWith(color: AppColor.black1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}