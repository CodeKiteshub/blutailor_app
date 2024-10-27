// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/gen/assets.gen.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    if (!sl<SharedPreferences>().containsKey('token')) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, "/splash1");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Assets.images.logo.image(width: 70.w),
            SizedBox(
              height: 2.h,
            ),
            LoadingAnimationWidget.beat(color: Colors.white, size: 3.h)
          ],
        ),
      ),
    );
  }
}
