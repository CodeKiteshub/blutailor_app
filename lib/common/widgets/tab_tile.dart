
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TabTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onTap;
  const TabTile({
    super.key,
    required this.title,
    required this.isSelected, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: BoxDecoration(
            color: isSelected ? primaryBlue : Colors.white,
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(color: isSelected ? Colors.white : primaryBlue),
            boxShadow: [
              BoxShadow(
                color: const Color(0XFF3A57E8).withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Text(title,
            style: TextStyle(
                color: isSelected ? Colors.white : primaryBlue,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
