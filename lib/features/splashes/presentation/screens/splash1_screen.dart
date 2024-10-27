import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Splash1Screen extends StatelessWidget {
  const Splash1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(splash1), fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 2.h,
            left: 5.w,
            right: 5.w,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.51),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Premium Alteration",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 1.h),
                    Text.rich(TextSpan(
                        text: "Blutailor ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800),
                        children: [
                          TextSpan(
                              text: "offers bespoke ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                            text: "alteration services ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                              text:
                                  "directly to your doorstep. Get your wardrobe refreshed and tailored to your exact preferences.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                        ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/splash2");
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  color: primaryRed,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
