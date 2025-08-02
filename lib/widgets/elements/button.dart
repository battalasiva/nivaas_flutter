import 'package:flutter/material.dart';
import '../../core/constants/gradients.dart';

class CustomizedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle style;
  final bool isReadOnly;

  const CustomizedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.style,
    this.isReadOnly = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: isReadOnly ? AppGradients.greyGradient : AppGradients.gradient2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: onPressed, 
        child: Text(
          label,
          style: style,
        ),
      ),
    );
  }
}
