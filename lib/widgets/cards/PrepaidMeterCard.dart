import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';

class PrepaidMeterCard extends StatelessWidget {
  final String meterName;
  final VoidCallback onAddConsumption;
  final String? buttonTitle;
  final bool? isAdmin,isLeftSelected,isReadOnly;

  const PrepaidMeterCard({
    super.key,
    required this.meterName,
    required this.onAddConsumption,
    this.buttonTitle,
    this.isAdmin,
    this.isLeftSelected,
    this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      color: AppColor.blueShade,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              meterName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.black1,
              ),
            ),
            SizedBox(
              width: buttonTitle == "View Details" ? 150 : 180,
              child: ElevatedButton(
                onPressed: onAddConsumption,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  buttonTitle ?? "Add Consumption",
                  style: TextStyle(color: AppColor.white),
                  maxLines: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
