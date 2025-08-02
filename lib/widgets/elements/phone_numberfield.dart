import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const PhoneNumberField({
    super.key,
    required this.controller,
    this.validator
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTextLength);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextLength);
    super.dispose();
  }

  void _updateTextLength() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.greyBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppColor.greyBorder),
                  ),
                ),
                child: Text(
                  '+91',
                  style: txt_14_700.copyWith(color: AppColor.black),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  validator: widget.validator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter your number',
                    hintStyle: txt_12_600.copyWith(color: AppColor.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                      borderSide: BorderSide.none
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 18.0),
                    counterText: ''
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${widget.controller.text.length}/10',
              style: txt_12_600.copyWith(color: AppColor.grey),
            ),
          ),
        ),
      ],
    );
  }
}
