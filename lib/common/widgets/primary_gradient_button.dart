import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String title;
  final bool isRedButton;
  final Function() onPressed;
  const PrimaryGradientButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isRedButton = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Device.screenType == ScreenType.tablet ? 3.h : 1.5.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isRedButton == true ? primaryRed : null,
            gradient: isRedButton == true ? null : primaryGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.168),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.084),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(5.0)),
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
