import 'package:bluetailor_app/common/widgets/phone_text_field.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginWithPasswordWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final Function(CountryCode) onCountryChanged;
  final Function() onLoginPressed;
  final Function() onForgotPasswordPressed;
  const LoginWithPasswordWidget(
      {super.key,
      required this.phoneController,
      required this.passwordController,
      required this.onCountryChanged,
      required this.onLoginPressed, required this.onForgotPasswordPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Sign In With Password",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 3.h),
        PhoneTextField(
            controller: phoneController, onCountryChanged: onCountryChanged),
        SizedBox(height: 1.h),
        PrimaryTextField(title: "Password", controller: passwordController),
        SizedBox(height: 2.h),
        InkWell(
          onTap: onForgotPasswordPressed,
          child: Text(
            "Forgot Password?",
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
      ],
    );
  }
}
