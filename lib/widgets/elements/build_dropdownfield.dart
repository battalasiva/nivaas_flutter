import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class BuildDropDownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final bool useBlueShadeBackground; 

  const BuildDropDownField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    this.validator,
    this.borderColor,
    this.useBlueShadeBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedValue = items.contains(value) ? value : null;
    final Color effectiveBorderColor = borderColor ?? AppColor.greyBorder;
    final Color backgroundColor =
        useBlueShadeBackground ? AppColor.blueShade : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, 
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        hint: Text(label),
        isExpanded: false,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        value: selectedValue,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColor.black2,
        ),
        isDense: true,
        dropdownColor: AppColor.white1,
      ),
    );
  }
}
