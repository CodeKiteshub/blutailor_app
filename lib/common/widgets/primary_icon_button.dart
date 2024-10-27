import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class PrimaryIconButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final String icon;
  const PrimaryIconButton(
      {super.key, required this.title, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
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
        ], borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 3.w),
            Text(title,
                style: TextStyle(
                    color: primaryBlack,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
