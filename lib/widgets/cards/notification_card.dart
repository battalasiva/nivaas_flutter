import 'package:flutter/material.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/img_consts.dart';
import '../../core/constants/text_styles.dart';

class NotificationCard extends StatelessWidget {
  final String date;
  final String title;
  final String msg;
  final String role;

  const NotificationCard({
    super.key,
    required this.date,
    required this.title,
    required this.msg,
    required this.role,
  });

  String getNotificationType(String title) {
    if (title.toLowerCase().contains('remind apartment admin')) {
      return 'Reminder';
    } else if (title.toLowerCase().contains('society due')) {
      return 'Society Due';
    } else if (title.toLowerCase().contains('flat approved') ||
        title.toLowerCase().contains('flat onboard')) {
      return 'Requests';
    }
    return 'Notice'; 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.blueShade,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.blue.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  getNotificationType(title), 
                  style: txt_9_500.copyWith(color: AppColor.white1),
                ),
              ),
              const Spacer(),
              Image.asset(
                noticeDate,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 10),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.red,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                formatDate(date),
                style: txt_11_500.copyWith(color: AppColor.black2),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: txt_13_600.copyWith(color: AppColor.black2),
          ),
          const SizedBox(height: 8),
          Text(
            msg,
            style: txt_13_400.copyWith(color: AppColor.black2),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
