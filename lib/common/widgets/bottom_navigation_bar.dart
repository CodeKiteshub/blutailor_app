// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:bluetailor_app/features/appointment/presentation/screens/create_appointment.dart';
import 'package:bluetailor_app/features/home/presentation/screens/home.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const Home(),
    BlocProvider(
      create: (context) => sl<AppointmentCubit>(),
      child: const CreateAppointment(),
    ),
    //  const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: const BoxDecoration(
            color: Color(0XFF051421),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      homeIcon,
                      height: 3.h,
                      color: currentIndex == 0
                          ? primaryRed
                          : const Color(0XFFB6B6B6),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: currentIndex == 0
                            ? primaryRed
                            : const Color(0XFFB6B6B6),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      appointmentIcon,
                      height: 3.h,
                      color: currentIndex == 1
                          ? primaryRed
                          : const Color(0XFFB6B6B6),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      "Appointments",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: currentIndex == 1
                            ? primaryRed
                            : const Color(0XFFB6B6B6),
                      ),
                    ),
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       currentIndex = 2;
              //     });
              //   },
              //   child: Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       SvgPicture.asset(
              //         orderIcon,
              //         height: 3.h,
              //         color: currentIndex == 2
              //             ? primaryRed
              //             : const Color(0XFFB6B6B6),
              //       ),
              //       SizedBox(
              //         height: 0.5.h,
              //       ),
              //       Text(
              //         "Track Order",
              //         style: TextStyle(
              //           fontSize: 13.sp,
              //           fontWeight: FontWeight.w700,
              //           color: currentIndex == 2
              //               ? primaryRed
              //               : const Color(0XFFB6B6B6),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          )),
    );
  }
}
