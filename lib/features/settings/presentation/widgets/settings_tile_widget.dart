

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsTileWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  const SettingsTileWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: primaryBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp)),
           Icon(
            Icons.arrow_forward_ios,
            color: primaryBlack,
            size: 16.sp,
          )
        ],
      ),
    );
  }
}
