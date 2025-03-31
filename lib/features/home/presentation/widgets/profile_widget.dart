import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          Navigator.pushNamed(context, '/settings');
        }
      },
      child: BlocBuilder<AppUserCubit, AppUserState>(
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return Container(
              decoration: BoxDecoration(
                  color: const Color(0XFF051421),
                  borderRadius: BorderRadius.circular(4.h)),
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0.5.w),
                      decoration: const BoxDecoration(
                        gradient: borderGradient,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                          radius: 5.5.w,
                          backgroundColor: Colors.black,
                          backgroundImage: state.user.profilePic == ""
                              ? null
                              : NetworkImage(state.user.profilePic)),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ${state.user.firstName}",
                          style: TextStyle(
                              fontSize: Device.screenType == ScreenType.tablet
                                  ? 16.sp
                                  : null,
                              fontFamily: "dmsans",
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          state.user.location,
                          style: TextStyle(
                              fontFamily: "dmsans",
                              fontSize: Device.screenType == ScreenType.tablet
                                  ? 16.sp
                                  : null,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
