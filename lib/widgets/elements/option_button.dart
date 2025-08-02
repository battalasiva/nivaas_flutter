import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class OptionButton extends StatelessWidget {
  final String label;
  final String selectedOption;
  final ValueChanged<String> onPressed;

  const OptionButton({super.key, 
    required this.label,
    required this.selectedOption,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressed(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedOption == label
              ? AppColor.primaryColor1
              : AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          label,
          style: txt_13_600.copyWith(
            color: selectedOption == label
                ? AppColor.white2
                : AppColor.black2,
          ),
        ),
      ),
    );
  }
}
