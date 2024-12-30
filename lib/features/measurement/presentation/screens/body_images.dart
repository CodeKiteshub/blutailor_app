// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/pick_img_bottomsheet.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/widget/body_image_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class BodyImages extends StatefulWidget {
  final List<SelectedCatModel> selectedCat;
  final String? frontSavedPicture;
  final String? backSavedPicture;
  final String? sideSavedPicture;
  const BodyImages(
      {super.key,
      required this.selectedCat,
      this.frontSavedPicture,
      this.backSavedPicture,
      this.sideSavedPicture});

  @override
  State<BodyImages> createState() => _BodyImagesState();
}

class _BodyImagesState extends State<BodyImages> {
  String frontImg = "";
  String backImg = "";
  String sideImg = "";

  String? frontPicture;
  String? backPicture;
  String? sidePicture;

  @override
  void initState() {
    context.read<BodyProfileCubit>().fetchBodyProfile();
    if (widget.frontSavedPicture != null) {
      frontPicture = widget.frontSavedPicture;
    }
    if (widget.backSavedPicture != null) {
      backPicture = widget.backSavedPicture;
    }
    if (widget.sideSavedPicture != null) {
      sidePicture = widget.sideSavedPicture;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Measurements (Custom)"),
      body: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
          top: 3.h,
        ),
        child: ListView(
          children: [
            BodyImageBox(
                title: "Front Facing Image",
                img: frontImg,
                dummyImg: "assets/images/front_img.png",
                savedImg: frontPicture,
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
                                    frontImg = croppedFile.path;
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
                                    frontImg = croppedFile.path;
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                          ));
                }),
            SizedBox(
              height: 3.h,
            ),
            BodyImageBox(
                title: "Back Facing Image",
                img: backImg,
                dummyImg: "assets/images/back_img.png",
                savedImg: backPicture,
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
                                    backImg = croppedFile.path;
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
                                    backImg = croppedFile.path;
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                          ));
                }),
            SizedBox(
              height: 3.h,
            ),
            BodyImageBox(
                title: "Side Facing Image",
                img: sideImg,
                dummyImg: "assets/images/side_img.png",
                savedImg: sidePicture,
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
                                    sideImg = croppedFile.path;
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
                                    sideImg = croppedFile.path;
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                          ));
                }),
            SizedBox(
              height: 5.h,
            ),
            BlocListener<BodyProfileCubit, BodyProfileState>(
              listener: (context, state) {
                if (state.status == BodyProfileStatus.loading) {
                  LoadingDialog(context);
                }
                if (state.status == BodyProfileStatus.error ||
                    state.status == BodyProfileStatus.imgError) {
                  Navigator.pop(context);
                  PrimarySnackBar(context, "Something went wrong.", Colors.red);
                }
                if (state.status == BodyProfileStatus.saved) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  PrimarySnackBar(
                      context, "Images uploaded successfully.", Colors.green);

                  if (widget.selectedCat.length == 1) {
                    Navigator.pushNamed(context, '/measurement-details',
                            arguments: {
                              'selectedCat': widget.selectedCat.first,
                              "isSingle": true
                            });
                  } else {
                    Navigator.of(context).pushNamed('/selected-cat',
                        arguments: {
                          'selectedCat': widget.selectedCat,
                          'fromCustom': true
                        });
                  }
                }
              },
              child: PrimaryGradientButton(
                  title: "Proceed",
                  onPressed: () {
                    if ((frontImg == "" && frontPicture == null) &&
                        (backImg == "" && backPicture == null) &&
                        (sideImg == "" && sidePicture == null)) {
                      PrimarySnackBar(
                          context, "Please Upload Images", Colors.red);
                    } else if (frontPicture != null ||
                        backPicture != null ||
                        sidePicture != null) {
                      if (widget.selectedCat.length == 1) {
                        Navigator.pushNamed(context, '/measurement-details',
                            arguments: {
                              'selectedCat': widget.selectedCat.first,
                              "isSingle": true
                            });
                      } else {
                        Navigator.of(context).pushNamed('/selected-cat',
                            arguments: {
                              'selectedCat': widget.selectedCat,
                              'fromCustom': true
                            });
                      }
                    } else {
                      final user = (context.read<AppUserCubit>().state
                              as AppUserLoggedIn)
                          .user;
                      context.read<BodyProfileCubit>().saveBodyImages(
                          user: user,
                          front: frontImg,
                          back: backImg,
                          side: sideImg);
                    }
                  }),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                if (widget.selectedCat.length == 1) {
                  Navigator.pushNamed(context, '/measurement-details',
                      arguments: widget.selectedCat.first);
                } else {
                  Navigator.of(context).pushNamed('/selected-cat',
                      arguments: widget.selectedCat);
                }
              },
              child: Text(
                "Skip",
                style: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryRed),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
