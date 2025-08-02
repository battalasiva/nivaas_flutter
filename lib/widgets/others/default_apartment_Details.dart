import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';

class DefaultApartmentDetails extends StatelessWidget {
  final String label;
  final String value;

  const DefaultApartmentDetails({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: txt_12_500.copyWith(color: AppColor.black),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: getWidth(context) / 2.3,
            child: Text(
              value,
              style: txt_14_500.copyWith(color: AppColor.blue),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
