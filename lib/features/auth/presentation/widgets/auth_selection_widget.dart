
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthSelectionWidget extends StatelessWidget {
  final Function() onLoginPressed;
  final Function() onSignUpPressed;
  const AuthSelectionWidget({
    super.key, required this.onLoginPressed, required this.onSignUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Let's Get Started",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 3.h),
        PrimaryGradientButton(
          title: 'Login',
          onPressed: onLoginPressed
        ),
        SizedBox(height: 2.h),
        Align(
          alignment: Alignment.center,
          child: Text("OR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
        ),
        SizedBox(height: 2.h),
        PrimaryGradientButton(
          title: 'Sign Up',
          onPressed: onSignUpPressed
        ),
      ],
    );
  }
}
