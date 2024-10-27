
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeHeading extends StatelessWidget {
  final String title;
  const HomeHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17.sp),
    );
  }
}
