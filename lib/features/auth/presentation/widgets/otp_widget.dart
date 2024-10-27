import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class OtpWidget extends StatelessWidget {
  final TextEditingController pinController;
  final Function() onLoginPressed;
  final Function() onResendPressed;
  const OtpWidget(
      {super.key,
      required this.onLoginPressed,
      required this.onResendPressed,
      required this.pinController});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Enter OTP",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 3.h),
        Pinput(
            controller: pinController,
            length: 6,
            showCursor: true,
            defaultPinTheme: PinTheme(
              height: 7.h,
              width: 16.w,
              decoration: BoxDecoration(
                color: hintColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            focusedPinTheme: PinTheme(
              height: 7.h,
              width: 16.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                // border: Border.all(color: primaryRed, width: 2),
              ),
            )),
        SizedBox(height: 1.h),
        Text(otpText,
            style: TextStyle(
                color: const Color(0XFFC4C4C4),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 2.h),
        InkWell(
          onTap: onResendPressed,
          child: Text(
            "Resend OTP",
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
