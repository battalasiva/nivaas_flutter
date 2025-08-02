import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/others/MeterDetails_popup.dart';

class Admin_prepaidMeter extends StatelessWidget {
  final String meterName;
  final String costPerUnit;
  final String unitsConsumed;
  final String? previousReading, dueDate, currentReading, costPerPrepaidMeter;
  final double? meterCost;
  final List<Map<String, dynamic>>? configRangeList;

  const Admin_prepaidMeter({
    super.key,
    required this.meterName,
    required this.costPerUnit,
    required this.unitsConsumed,
    this.previousReading,
    this.meterCost,
    this.dueDate,
    this.configRangeList,
    this.currentReading,
    this.costPerPrepaidMeter,
  });

  @override
  Widget build(BuildContext context) {
    // print('AAAA:$configRangeList');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
              width: getWidth(context) * 0.72,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        meterName,
                        style:
                            txt_12_500.copyWith(color: AppColor.primaryColor1),
                      ),
                      if (costPerPrepaidMeter != 'null')
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Rs ',
                                style:
                                    txt_10_500.copyWith(color: AppColor.black2),
                              ),
                              TextSpan(
                                text: costPerPrepaidMeter,
                                style:
                                    txt_12_500.copyWith(color: AppColor.black2),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              )),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              _showMeterDetailsPopup(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColor.primaryColor1,
            ),
            child: Text(
              'View',
              style: txt_11_500.copyWith(color: AppColor.white1),
            ),
          ),
        ],
      ),
    );
  }

  void _showMeterDetailsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MeterDetailsPopup(
          meterName: meterName,
          costPerUnit: costPerUnit,
          unitsConsumed: unitsConsumed,
          meterCost: meterCost,
          configRangeList: configRangeList,
          dueDate: dueDate!,
          previousReading: previousReading,
          currentReading: currentReading,
        );
      },
    );
  }
}
