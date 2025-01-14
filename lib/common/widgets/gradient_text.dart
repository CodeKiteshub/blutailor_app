import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GradientText extends StatelessWidget {
  final String text;
  const GradientText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => primaryGradient.createShader(bounds),
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.sp),
      ),
    );
  }
}
