import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class MeterDetailsPopup extends StatelessWidget {
  final String meterName;
  final String costPerUnit;
  final String unitsConsumed;
  final double? meterCost;
  final String dueDate;
  final List<Map<String, dynamic>>? configRangeList;
  final String? previousReading, currentReading;

  const MeterDetailsPopup({
    super.key,
    required this.meterName,
    required this.costPerUnit,
    required this.unitsConsumed,
    this.meterCost,
    this.configRangeList,
    required this.dueDate,
    this.previousReading,
    this.currentReading,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                meterName,
                style: txt_17_700.copyWith(color: AppColor.primaryColor1),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.blueShade,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  if (currentReading != null && previousReading != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Previous Meter Reading :',
                            style: txt_12_500.copyWith(
                                color: AppColor.primaryColor1)),
                        Text(previousReading ?? '0',
                            style: txt_12_500.copyWith(color: AppColor.black1)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Current Meter Reading :',
                            style: txt_12_500.copyWith(
                                color: AppColor.primaryColor1)),
                        Text(currentReading ?? '0',
                            style: txt_12_500.copyWith(color: AppColor.black1)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Units Consumed :',
                          style: txt_12_500.copyWith(
                              color: AppColor.primaryColor1)),
                      Text(unitsConsumed,
                          style: txt_12_500.copyWith(color: AppColor.black1)),
                    ],
                  ),
                  // const SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Cost Per Meter :',
                  //         style: txt_12_500.copyWith(
                  //             color: AppColor.primaryColor1)),
                  //     Text('Rs $costPerPrepaidMeter',
                  //         style: txt_12_500.copyWith(color: AppColor.black1)),
                  //   ],
                  // ),
                  const SizedBox(height: 8),
                  if (configRangeList != null && configRangeList!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cost Per Unit :',
                          style: txt_13_500.copyWith(
                              color: AppColor.primaryColor1),
                        ),
                        const SizedBox(height: 8),
                        ...configRangeList!.map((range) {
                          return Container(
                            padding: EdgeInsets.all(6.0),
                            color: AppColor.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '[${range['startRange']} - ${range['endRange'] ?? 'Infinite'}]',
                                  style: txt_12_500.copyWith(
                                      color: AppColor.black1),
                                ),
                                Text(
                                  'Rs ${range['costPerUnit']} per unit',
                                  style: txt_12_500.copyWith(
                                      color: AppColor.black1),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cost Per Unit :',
                            style: txt_12_500.copyWith(
                                color: AppColor.primaryColor1)),
                        Text('Rs $costPerUnit',
                            style: txt_12_500.copyWith(color: AppColor.black1)),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Bill Generated On : ${formatDate(dueDate)}',
                style: txt_12_500.copyWith(color: AppColor.black1),
              ),
            ),
            const SizedBox(height: 20),
            CustomizedButton(
              label: 'Done',
              style: txt_11_500.copyWith(color: AppColor.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
