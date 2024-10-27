// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class LoginSuccessful extends StatefulWidget {
  const LoginSuccessful({super.key});

  @override
  State<LoginSuccessful> createState() => _LoginSuccessfulState();
}

class _LoginSuccessfulState extends State<LoginSuccessful> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, '/bottom-bar', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.loginSuccess.image(height: 30.h),
            Assets.images.logo.image(width: 30.h),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login Successful",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 3.w,
                ),
                LoadingAnimationWidget.beat(color: Colors.white, size: 3.h)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
