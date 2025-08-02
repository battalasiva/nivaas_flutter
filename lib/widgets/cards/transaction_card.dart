import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class TransactionCard extends StatelessWidget {
  final bool isCredit;
  final String name;
  final String amount;
  final String time;
  final String description;
  final String? lastUpdated;

  const TransactionCard({
    super.key,
    required this.isCredit,
    required this.name,
    required this.amount,
    required this.time,
    required this.description,
    this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColor.blueShade,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(
                    isCredit ? creditArrow : debitArrow,
                    height: 28,
                    width: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isCredit ? "Credited" : "Paid to",
                            style: txt_16_700.copyWith(color: AppColor.black),
                          ),
                          Text(
                            '${isCredit ? "+" : "-"}₹ $amount',
                            style: txt_16_700.copyWith(
                              color: isCredit ? AppColor.green : AppColor.red,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getWidth(context) * 0.35,
                            child: Text(
                              description,
                              style: txt_14_400.copyWith(
                                  color: AppColor.primaryColor2),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            formatDate(time),
                            style: txt_12_500.copyWith(color: AppColor.black2),
                          ),
                        ],
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
