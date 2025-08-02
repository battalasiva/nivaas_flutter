import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';

class AppGradients {
  static var gradient1 =  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColor.primaryColor1,
      AppColor.primaryColor2
    ]
  );
  static var greyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColor.greyBorder,
      AppColor.grey,
    ]
  );
  static var gradient2 =  LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColor.primaryColor2,
      AppColor.primaryColor1
    ]
  );
}

class GradientText extends StatelessWidget{
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText(this.text, {super.key, required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}