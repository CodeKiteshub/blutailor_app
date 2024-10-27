import 'package:bluetailor_app/common/widgets/phone_text_field.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_icon_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginWithOTP extends StatelessWidget {
  final TextEditingController phoneController;
  final Function() onLoginPasswordPressed;
  final Function(CountryCode) onCountryChanged;
  final Function() onLoginPressed;
  final Function() onGooglePressed;
  const LoginWithOTP(
      {super.key,
      required this.onLoginPasswordPressed,
      required this.phoneController,
      required this.onCountryChanged,
      required this.onLoginPressed,
      required this.onGooglePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Sign In",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 3.h),
        PhoneTextField(
            controller: phoneController, onCountryChanged: onCountryChanged),
        SizedBox(height: 1.h),
        Text(loginWithOtp,
            style: TextStyle(
                color: const Color(0XFFC4C4C4),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 2.h),
        InkWell(
          onTap: onLoginPasswordPressed,
          child: Text(
            "Login with Password",
            style: TextStyle(
              color: primaryRed,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: primaryRed,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        PrimaryGradientButton(title: 'Proceed', onPressed: onLoginPressed),
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
        PrimaryIconButton(
            title: "Continue with Google",
            icon: google,
            onPressed: onGooglePressed),
      ],
    );
  }
}
