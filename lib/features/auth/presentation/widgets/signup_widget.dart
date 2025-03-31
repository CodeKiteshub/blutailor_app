import 'package:bluetailor_app/common/widgets/phone_text_field.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignupWidget extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final Function(CountryCode) onCountryChanged;
  final Function() onSignupPressed;
  const SignupWidget(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.passwordController,
      required this.phoneController,
      required this.onSignupPressed, required this.onCountryChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 3.h),
        Row(
          children: [
            Expanded(child: PrimaryTextField(title: "First Name", controller: firstNameController)),
            SizedBox(width: 2.w),
            Expanded(child: PrimaryTextField(title: "Last Name", controller: lastNameController)),
          ],
        ),
        SizedBox(height: 2.h),
        PhoneTextField(controller: phoneController,onCountryChanged: onCountryChanged,),
        SizedBox(height: 2.h),
        PrimaryTextField(title: "Email", controller: emailController),
        SizedBox(height: 2.h),
        PrimaryTextField(title: "Password", controller: passwordController),
        SizedBox(height: 1.h),
        Text.rich(TextSpan(
            text: "By selecting Agree and continue below, I agree to the ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                  text: "Terms of Service and Privacy Policy",
                  style: TextStyle(
                      color: primaryRed,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400)),
            ])),
        SizedBox(height: 3.h),
        PrimaryGradientButton(title: "Agree and Continue", onPressed: onSignupPressed)
      ],
    );
  
  }
}
