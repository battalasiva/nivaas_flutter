import 'package:flutter/material.dart';


class ShortButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle style;
  final Color color;

  const ShortButton(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.style,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          side: BorderSide(color: Colors.transparent),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
          ),
        child: Text(
          label,
          style: style,
        ));
  }
}
