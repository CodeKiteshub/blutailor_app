import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/settings_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    log('Memory usage before dispose: ${(ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2)} MB');
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(),
              BlocBuilder<AppUserCubit, AppUserState>(
                bloc: context.read<AppUserCubit>(),
                builder: (context, state) {
                  if (state is AppUserLoggedIn) {
                    return Column(
                      children: [
                        CircleAvatar(
                            radius: 20.w,
                            backgroundImage: state.user.profilePic == ""
                                ? null
                                : NetworkImage(
                                    state.user.profilePic,
                                    headers: {
                                      'Cache-Control': 'no-cache',
                                      'Pragma': 'no-cache',
                                    },
                                  )),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "${state.user.firstName} ${state.user.lastName}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp),
                        ),
                        //  SizedBox(height: 1.h,),
                        Text(state.user.location,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp)),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: 7.w, right: 7.w, top: 3.h,),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Settings",
                            style: TextStyle(
                                color: primaryBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 21.sp)),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Edit Profile",
                          onTap: () {
                            Navigator.pushNamed(context, '/edit-profile');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Orders",
                          onTap: () {
                            Navigator.pushNamed(context, '/orders');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Appointments",
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/appointment-history');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Custom Made",
                          onTap: () {
                            Navigator.pushNamed(context, '/custom-made-home');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Address",
                          onTap: () {
                            Navigator.pushNamed(context, '/address',
                                arguments: false);
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Measurement",
                          onTap: () {
                            Navigator.pushNamed(context, '/measurement-home');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Chat with expert",
                          onTap: () {
                            Navigator.pushNamed(context, '/chat-screen');
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SettingsTileWidget(
                          title: "Delete Account",
                          onTap: () {
                            DefaultDialog(context,
                                title: "Confirm Log Out?",
                                message:
                                    "Are you sure you want to delete account?",
                                cancelText: "No",
                                confirmText: "Yes", onCancel: () {
                              Navigator.pop(context);
                            }, onConfirm: () async {
                              var url =
                                  "https://www.mpfstyleclub.com/delete-account";
                              if (!await launchUrl(Uri.parse(url))) {
                                throw Exception('Could not launch $url');
                              }
                            });
                          },
                        ),
                        //  const Spacer(),
                        SizedBox(height: 4.h,),
                        BlocListener<AuthBloc, AuthState>(
                          bloc: context.read<AuthBloc>(),
                          listener: (context, state) {
                            if (state is AuthLoading) {
                              LoadingDialog(context);
                            }
                            if (state is AuthLoggedOut) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/auth-selection', (route) => false);
                            }
                            if (state is AuthError) {
                              PrimarySnackBar(
                                  context, state.message, Colors.red);
                            }
                          },
                          child: PrimaryGradientButton(
                              title: "Log Out",
                              isRedButton: true,
                              onPressed: () {
                                DefaultDialog(context,
                                    title: "Confirm Log Out?",
                                    message:
                                        "Are you sure you want to log out?",
                                    cancelText: "No",
                                    confirmText: "Yes", onCancel: () {
                                  Navigator.pop(context);
                                }, onConfirm: () {
                                  context.read<AuthBloc>().add(LogoutEvent());
                                });
                              }),
                        )
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
