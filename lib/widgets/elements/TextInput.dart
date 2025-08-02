import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
 
class TextInputWidget extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? hint;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String? suffix;
  final bool digitsOnly;
  final bool decimalOnly;
  final int? maxLength;

  const TextInputWidget({
    Key? key,
    this.label,
    required this.controller,
    this.hint,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffix,
    this.digitsOnly = false,
    this.decimalOnly = false, // Default to false
    this.maxLength,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor = AppColor.greyBorder;
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: txt_14_600.copyWith(color: AppColor.black2),
          ),
        ],
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: decimalOnly
              ? const TextInputType.numberWithOptions(decimal: true)
              : digitsOnly
                  ? TextInputType.number
                  : keyboardType,
          inputFormatters: [
            if (digitsOnly) FilteringTextInputFormatter.digitsOnly,
            if (decimalOnly)
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            hintText: hint,
            suffix: suffix != null
                ? Text(
                    suffix!,
                    style: TextStyle(color: AppColor.primaryColor2),
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
 