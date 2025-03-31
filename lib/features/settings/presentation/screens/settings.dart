import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/settings_tile_widget.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';


// Import statements remain the same...

class Settings extends StatelessWidget {
  const Settings({super.key});

  // Extract constants
  static const double _avatarRadius = 20;
  static const String _deleteAccountUrl = "https://www.mpfstyleclub.com/delete-account";

  // Extract reusable widgets
  Widget _buildUserProfile(AppUserState state) {
    if (state is! AppUserLoggedIn) return const SizedBox.shrink();
    
    return Column(
      children: [
        CircleAvatar(
          radius: _avatarRadius.w,
          backgroundImage: state.user.profilePic.isEmpty
              ? null
              : NetworkImage(
                  state.user.profilePic,
                  headers: const {
                    'Cache-Control': 'no-cache',
                    'Pragma': 'no-cache',
                  },
                ),
        ),
        SizedBox(height: 2.h),
        Text(
          "${state.user.firstName} ${state.user.lastName}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        Text(
          state.user.location,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }

  // Extract settings items into a separate method
  List<Widget> _buildSettingsItems(BuildContext context) {
    final settingsItems = [
      _SettingsItem(
        title: "Edit Profile",
        onTap: () => _handleNavigation(context, '/edit-profile'),
        requiresAuth: true,
      ),
      _SettingsItem(
        title: "Orders",
        onTap: () => _handleNavigation(context, '/orders'),
        requiresAuth: true,
      ),
      _SettingsItem(
        title: "Appointments",
        onTap: () => Navigator.pushNamed(context, '/appointment-history'),
      ),
      _SettingsItem(
        title: "Address",
        onTap: () => Navigator.pushNamed(context, '/address', arguments: false),
      ),
      _SettingsItem(
        title: "Measurement",
        onTap: () => Navigator.pushNamed(context, '/measurement-home'),
      ),
      _SettingsItem(
        title: "Chat with expert",
        onTap: () => Navigator.pushNamed(context, '/chat-screen'),
      ),
      _SettingsItem(
        title: "Delete Account",
        onTap: () => _showDeleteAccountDialog(context),
      ),
    ];

    return settingsItems.expand((item) => [
      SettingsTileWidget(
        title: item.title,
        onTap: item.onTap,
      ),
      SizedBox(height: 3.h),
    ]).toList();
  }

  void _handleNavigation(BuildContext context, String route) {
    if (sl<SharedPreferences>().getString('userId') == null) {
      _showGuestDialog(context);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  void _showDeleteAccountDialog(BuildContext context) {
    DefaultDialog(
      context,
      title: "Confirm Log Out?",
      message: "Are you sure you want to delete account?",
      cancelText: "No",
      confirmText: "Yes",
      onCancel: () => Navigator.pop(context),
      onConfirm: () async {
        try {
          if (!await launchUrl(Uri.parse(_deleteAccountUrl))) {
            throw Exception('Could not launch $_deleteAccountUrl');
          }
        } catch (e) {
          debugPrint('Error launching URL: $e');
        }
      },
    );
  }

  void _showGuestDialog(BuildContext context) {
    DefaultDialog(
      context,
      title: "Alert!",
      message: "To use this feature, you will need to login as it is tied to your user specific profile",
      cancelText: "Cancel",
      confirmText: "Login/Signup",
      onCancel: () => Navigator.pop(context),
      onConfirm: () => Navigator.pushNamedAndRemoveUntil(
        context,
        "/auth-selection",
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    log('Memory usage: ${(ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2)} MB');

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppBarWidget(),
              BlocBuilder<AppUserCubit, AppUserState>(
                bloc: context.read<AppUserCubit>(),
                builder: (context, state) => _buildUserProfile(state),
              ),
              SizedBox(height: 3.h),
              Container(
                padding: EdgeInsets.only(
                  left: 7.w,
                  right: 7.w,
                  top: 3.h,
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: primaryBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 21.sp,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    ..._buildSettingsItems(context),
                    SizedBox(height: 4.h),
                    _buildLogoutButton(context),
                    SizedBox(height: 6.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: context.read<AuthBloc>(),
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingDialog(context);
        } else if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/auth-selection',
            (route) => false,
          );
        } else if (state is AuthError) {
          PrimarySnackBar(context, state.message, Colors.red);
        }
      },
      child: PrimaryGradientButton(
        title: "Log Out",
        isRedButton: true,
        onPressed: () => _showLogoutDialog(context),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    DefaultDialog(
      context,
      title: "Confirm Log Out?",
      message: "Are you sure you want to log out?",
      cancelText: "No",
      confirmText: "Yes",
      onCancel: () => Navigator.pop(context),
      onConfirm: () => context.read<AuthBloc>().add(LogoutEvent()),
    );
  }
}

// Helper class for settings items
class _SettingsItem {
  final String title;
  final VoidCallback onTap;
  final bool requiresAuth;

  const _SettingsItem({
    required this.title,
    required this.onTap,
    this.requiresAuth = false,
  });
}