// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/phone_text_field.dart';
import 'package:bluetailor_app/common/widgets/pick_img_bottomsheet.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _countryCode = '+91';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String profilePic = "";
  AppUserLoggedIn? user;

  @override
  void initState() {
    user = context.read<AppUserCubit>().state as AppUserLoggedIn;
    if (user != null) {
      _firstNameController.text = user!.user.firstName;
      _lastNameController.text = user!.user.lastName;
      _emailController.text = user!.user.email;
      _phoneController.text = user!.user.phone;
      profilePic = user!.user.profilePic;
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(
        title: "Edit Basic Profile",
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => ImgPickBottomSheet(
                          camTapped: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              final croppedFile = await cropImg(pickedFile);
                              if (croppedFile != null) {
                                setState(() {
                                  profilePic = croppedFile.path;
                                });
                              }
                            }
                            Navigator.pop(context);
                          },
                          galleryTapped: () async {
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              final croppedFile = await cropImg(pickedFile);
                              if (croppedFile != null) {
                                setState(() {
                                  profilePic = croppedFile.path;
                                });
                              }
                            }
                            Navigator.pop(context);
                          },
                        ));
              },
              child: Stack(
                children: [
                  profilePic == ""
                      ? CircleAvatar(
                          radius: 20.w,
                          backgroundColor: const Color(0xFFEAEAEA),
                          child: SvgPicture.asset(cameraIcon))
                      : profilePic.startsWith("https") == true
                          ? CircleAvatar(
                              radius: 20.w,
                              backgroundColor: const Color(0xFFEAEAEA),
                              backgroundImage: NetworkImage(profilePic))
                          : CircleAvatar(
                              radius: 20.w,
                              backgroundColor: const Color(0xFFEAEAEA),
                              backgroundImage: FileImage(File(profilePic))),
                  Positioned(
                    top: 5.w,
                    right: 2.w,
                    child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4))
                            ]),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 16.sp,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              "Tap above to upload your image",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: const Color(0xFF1E1E1E)),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Expanded(
                    child: PrimaryTextField(
                        title: "First Name",
                        border: true,
                        controller: _firstNameController)),
                SizedBox(width: 2.w),
                Expanded(
                    child: PrimaryTextField(
                        title: "Last Name",
                        border: true,
                        controller: _lastNameController)),
              ],
            ),
            SizedBox(height: 2.h),
            PhoneTextField(
              controller: _phoneController,
              border: true,
              onCountryChanged: (CountryCode countryCode) {
                setState(() {
                  _countryCode = countryCode.dialCode!;
                  log(_countryCode, name: "Country Code");
                });
              },
            ),
            SizedBox(height: 2.h),
            PrimaryTextField(
                title: "Email", border: true, controller: _emailController),
            const Spacer(),
            BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsLoading) {
                  LoadingDialog(context);
                }
                if (state is EditProfileDone) {
                  context.read<AuthBloc>().add(AuthIsLoggedIn());
                  Navigator.pop(context);
                  Navigator.pop(context);
                  imageCache.clear();
                  imageCache.clearLiveImages();
                  imageCache.evict((context.read<AppUserCubit>().state
                          as AppUserLoggedIn)
                      .user
                      .profilePic);
                  PrimarySnackBar(context, state.message, Colors.green);
                }
                if (state is SettingsError) {
                  Navigator.pop(context);
                  PrimarySnackBar(context, state.message, Colors.red);
                }
              },
              child: PrimaryGradientButton(
                  title: "Submit",
                  onPressed: () {
                    context.read<SettingsBloc>().add(EditProfileEvent(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        profilePicPath: profilePic));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
