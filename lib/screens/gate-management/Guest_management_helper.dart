import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';

Widget buildCategoryButton({
  required String label,
  required String assetName,
  required String? selectedCategory, // Nullable to avoid null errors
  required Function(String) onCategorySelected,
}) {
  bool isSelected = label == selectedCategory;

  return GestureDetector(
    onTap: () {
      onCategorySelected(label);
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColor.blue : AppColor.blueShade,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            assetName,
            width: 50,
            height: 50,
            color: isSelected ? AppColor.white : null,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: txt_15_500.copyWith(color: AppColor.black1),
          ),
        ),
      ],
    ),
  );
}
