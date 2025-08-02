import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class PointsListForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;
  final String labelText;
  final String validationMessage;
  final Function(String)? onChanged;

  const PointsListForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.labelText,
    required this.validationMessage,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controllers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              controller: controllers[index],
              decoration: InputDecoration(
                labelText: '$labelText ${index + 1}',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.black2),
                ),
                labelStyle: TextStyle(color: AppColor.greyText2), 
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return validationMessage;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: onChanged != null
                ? (value) {
                    if (onChanged != null) {
                      onChanged!(value); 
                    }
                  }
                : null,
            ),
          );
        },
      ),
    );
  }
}
