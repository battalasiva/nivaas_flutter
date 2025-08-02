import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class Textwithstar extends StatelessWidget {
  final String label;
  Textwithstar({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: txt_14_600.copyWith(color: AppColor.black2),
        ),
        Text(
          '*',
          style: txt_14_600.copyWith(color: AppColor.red),
        )
      ],
    );
  }
}