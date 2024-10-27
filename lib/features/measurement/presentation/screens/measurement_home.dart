import 'dart:ui';

import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MeasurementHome extends StatelessWidget {
  const MeasurementHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      extendBody: true,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(),
          Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.h),
            child: Text(
              "Measurements",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 3.w, right: 3.w),
            decoration: BoxDecoration(
              color: const Color(0xff051421),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Assets.images.measurementTop.image(
                  width: 25.w,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create your measurements",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Find your way to a perfect fit by providing your unique measurements here.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(3.w),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Measurement Type",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF383A3A),
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: const Color(
                                                            0xFF383A3A),
                                                        size: 20.sp,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              PrimaryGradientButton(
                                                  title: "Custom Sizing",
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/select-garment-cat',
                                                        arguments: true);
                                                  }),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              PrimaryGradientButton(
                                                  title: "Standard Sizing",
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/select-garment-cat',
                                                        arguments: false);
                                                  }),
                                              SizedBox(
                                                height: 2.h,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: borderGradient,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Create",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: 15.sp,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Expanded(
            child: Container(
              width: 100.w,
              padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "View Sizing",
                    style: TextStyle(
                        color: primaryBlack,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Tap on the options below to view your existing sizing",
                    style: TextStyle(
                        color: const Color(0xff757575),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/select-garment-cat',
                          arguments: true);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Assets.images.customSize.image(),
                        Positioned(
                          top: 1.h,
                          right: 3.w,
                          child: Assets.images.customIcon.image(
                            width: 10.w,
                          ),
                        ),
                        Positioned(
                          bottom: 2.h,
                          left: 3.w,
                          child: Text(
                            "Custom Sizing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/select-garment-cat',
                          arguments: false);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Assets.images.standardSize.image(),
                        Positioned(
                          top: 1.h,
                          right: 3.w,
                          child: Assets.images.standardIcon.image(
                            width: 10.w,
                          ),
                        ),
                        Positioned(
                          bottom: 2.h,
                          left: 3.w,
                          child: Text(
                            "Standard Sizing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
