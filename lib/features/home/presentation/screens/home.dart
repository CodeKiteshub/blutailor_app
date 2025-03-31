import 'package:bluetailor_app/common/widgets/cart_icon_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/youtube_player_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/home/presentation/widgets/home_heading.dart';
import 'package:bluetailor_app/features/home/presentation/widgets/profile_widget.dart';
import 'package:bluetailor_app/gen/assets.gen.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(2.w, 2.h, 5.w, 2.h),
              child: Row(
                children: [
                  const ProfileWidget(),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (sl<SharedPreferences>().getString('userId') == null) {
                        DefaultDialog(context,
                            title: "Alert!",
                            message:
                                "To use this feature, you will need to login as it is tied to your user specific profile",
                            cancelText: "Cancel",
                            confirmText: "Login/Signup", onCancel: () {
                          Navigator.pop(context);
                        }, onConfirm: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/auth-selection", (route) => false);
                        });
                      } else {
                        Navigator.pushNamed(context, '/measurement-home');
                      }
                    },
                    child: SvgPicture.asset(
                      measurement,
                      height: 3.h,
                    ),
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  const CartIconWidget()
                ],
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeading(
                    title: "Book an Appointment",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/create-appointment",
                          arguments: true);
                    },
                    child: HomeTile(
                      title: homeAppointment,
                      bottomText: true,
                      child: Assets.images.homeAppointment.image(
                        height: Device.screenType == ScreenType.tablet
                            ? 30.h
                            : null,
                        width: 100.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const HomeHeading(
                    title: "Our Services",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/select-alteration-cat');
                        },
                        child: HomeTile(
                            title: "Alteration",
                            child: Assets.images.homeAlteration.image()),
                      )),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/select-stitching-cat');
                        },
                        child: HomeTile(
                          title: "Stitching",
                          child: Assets.images.homeStitching.image(),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const HomeHeading(
                    title: "Custom Clothing",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/custom-made-home');
                      },
                      child: Stack(
                        children: [
                          Assets.images.homeGuide.image(),
                          Positioned(
                            bottom: 20,
                            left: 7.w,
                            right: 7.w,
                            child: Row(
                              children: [
                                Text(
                                    "Our professionally crafted\nclothes, Just for you!",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500)),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: const Offset(0, 4),
                                        )
                                      ]),
                                  child: Text(
                                    "Explore",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  const HomeHeading(
                    title: "Our Journey",
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  const YoutubePlayerWidget(videoId: "ApWf9IJQrac"),
                  SizedBox(
                    height: 3.h,
                  ),
                  const HomeHeading(
                    title: "Our Happy Clients",
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  const YoutubePlayerWidget(videoId: "0kiXr_hCJAA"),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}



class HomeTile extends StatelessWidget {
  final Widget child;
  final String title;
  final bool bottomText;
  const HomeTile(
      {super.key,
      required this.child,
      required this.title,
      this.bottomText = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 15,
          left: 3.w,
          right: 3.w,
          child: Column(
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500)),
              if (bottomText) ...[
                SizedBox(
                  height: 0.5.h,
                ),
                Text("Tap to book an appointment now",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300)),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
