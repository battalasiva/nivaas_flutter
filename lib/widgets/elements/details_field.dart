import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class DetailsField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? condition;
  final bool maxLengthCondition;
  final ValueChanged<String>? onChanged;
  final TextStyle? hintStyle;
  final FormFieldValidator<String>? validator;
  final Image? image;
  final bool? isOnlyNumbers;
  final bool? isDecimals;

  const DetailsField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.condition,
      this.maxLengthCondition = false,
      this.onChanged,
      this.hintStyle,
      this.validator,
      this.image,
      this.isOnlyNumbers = false,
      this.isDecimals =false
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: condition ?? true,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLengthCondition ? 10 : null,
      style: txt_12_500.copyWith(color: AppColor.black2),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? txt_11_600.copyWith(color: AppColor.greyText2),
        counterText: '',
        prefixIcon: image,
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.greyBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.greyBorder)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 17, vertical: 10.0),
      ),
      inputFormatters: isOnlyNumbers! ? [FilteringTextInputFormatter.digitsOnly] 
          :isDecimals! ? [FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}(\.\d{0,2})?$'))]: [],
    );
  }
}
