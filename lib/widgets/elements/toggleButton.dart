import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';

class ToggleButtonWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final bool isLeftSelected;
  final Function(bool) onChange;
  final bool isReadOnly;

  const ToggleButtonWidget({
    Key? key,
    required this.leftTitle,
    required this.rightTitle,
    required this.isLeftSelected,
    required this.onChange,
    this.isReadOnly = false,
  }) : super(key: key);

  void _handleTap(BuildContext context, bool value) {
    if (isReadOnly) {
      showSnackbarForNonAdmins(context);
    } else {
      onChange(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _handleTap(context, true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: isLeftSelected ? AppColor.blue : AppColor.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    leftTitle,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: isLeftSelected ? AppColor.white : AppColor.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _handleTap(context, false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: !isLeftSelected ? AppColor.blue : AppColor.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Text(
                    rightTitle,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: !isLeftSelected ? AppColor.white : AppColor.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
