import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? action;
  const PrimaryAppBar({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryBlue,
      toolbarHeight: 8.h,
      titleSpacing: 0,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding:  EdgeInsets.only( top: 2.8.h, bottom: 2.8.h),
          child: SvgPicture.asset(backIcon),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20.sp, color: Colors.white),
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(8.h);
}
