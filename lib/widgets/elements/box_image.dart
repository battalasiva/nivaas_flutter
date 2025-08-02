import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';

class BoxImage extends StatelessWidget {
  final String label, imagePath, selectedItem;
  final Function(String) onSelect;

  const BoxImage({
    super.key, 
    required this.label, required this.imagePath,
     required this.selectedItem,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(label); 
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedItem == label ? AppColor.primaryColor1 :  AppColor.blueShade,
          border: Border.all(color: AppColor.greyBorder)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 33,
              height: 33,
              fit: BoxFit.cover,
              color: selectedItem == label ? AppColor.white : null
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: txt_12_500.copyWith(color: AppColor.black2),
            ),
          ],
        ),
      ),
    );
  }
}