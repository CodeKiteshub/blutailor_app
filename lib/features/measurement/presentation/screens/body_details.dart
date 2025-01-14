import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/widget/body_item_tile.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class BodyDetails extends StatefulWidget {
  final List<SelectedCatModel> selectedCat;
  const BodyDetails({super.key, required this.selectedCat});

  @override
  State<BodyDetails> createState() => _BodyDetailsState();
}

class _BodyDetailsState extends State<BodyDetails> {
  String selectedHeightCat = "feet";

  @override
  void initState() {
    context.read<BodyProfileCubit>().fetchBodyProfile();
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
        child: BlocConsumer<BodyProfileCubit, BodyProfileState>(
            listener: (context, state) {
              if (state.status == BodyProfileStatus.error) {
                Navigator.pop(context);
                PrimarySnackBar(
                    context, "Something went wrong.", Colors.red);
              }
              if (state.status == BodyProfileStatus.saved) {
                Navigator.pop(context);
                PrimarySnackBar(
                    context, "Body Profile Updated", Colors.green);
            
                Navigator.pushNamed(context, '/body-images', arguments: {
                  "selectedCat": widget.selectedCat,
                  "frontSavedPicture":
                      context.read<BodyProfileCubit>().frontImg,
                  "sideSavedPicture":
                      context.read<BodyProfileCubit>().sideImg,
                  "backSavedPicture":
                      context.read<BodyProfileCubit>().backImg,
                });
              }
              if (state.status == BodyProfileStatus.loading) {
                LoadingDialog(context);
              }
            },
            builder: (context, state) => state.status ==
                    BodyProfileStatus.loading
                ? LoadingAnimationWidget.beat(
                    color: primaryBlue, size: 50)
                : ListView(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Body Profile Details",
                          style: TextStyle(
                              color: primaryBlack,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Age (in years)",
                        style: TextStyle(
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      PrimaryTextField(
                          title: "Age",
                          border: true,
                          controller: context
                              .read<BodyProfileCubit>()
                              .ageController),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Height",
                        style: TextStyle(
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          selectedHeightCat == "feet"
                              ? Expanded(
                                  child: PrimaryTextField(
                                  title: "Feet",
                                  border: true,
                                  controller: context
                                      .read<BodyProfileCubit>()
                                      .feetController,
                                ))
                              : Expanded(
                                  child: PrimaryTextField(
                                  title: 'cm',
                                  border: true,
                                  controller: context
                                      .read<BodyProfileCubit>()
                                      .cmController,
                                )),
                          SizedBox(
                            width: 2.w,
                          ),
                          selectedHeightCat == "feet"
                              ? Expanded(
                                  child: PrimaryTextField(
                                  title: "Inches",
                                  border: true,
                                  controller: context
                                      .read<BodyProfileCubit>()
                                      .inchesController,
                                ))
                              : const SizedBox.shrink(),
                          if (selectedHeightCat == "feet")
                            SizedBox(
                              width: 2.w,
                            ),
                          Expanded(
                              child: Container(
                            padding:
                                EdgeInsets.only(left: 3.w, right: 3.w),
                            constraints: BoxConstraints(minHeight: 6.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xffc7c7c7)),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButton<String>(
                                items: [
                                  DropdownMenuItem(
                                      value: "feet",
                                      child: Text(
                                        "Feet",
                                        style: TextStyle(
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                            color:
                                                const Color(0xff444444)),
                                      )),
                                  DropdownMenuItem(
                                      value: "cm",
                                      child: Text(
                                        "Centimeter",
                                        style: TextStyle(
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                            color:
                                                const Color(0xff444444)),
                                      )),
                                ],
                                iconEnabledColor: const Color(0xff444444),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                underline: Container(),
                                value: selectedHeightCat,
                                onChanged: (value) {
                                  setState(() {
                                    selectedHeightCat = value!;
                                  });
                                }),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "Weight (in kg)",
                        style: TextStyle(
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      PrimaryTextField(
                        title: "Weight",
                        border: true,
                        controller: context
                            .read<BodyProfileCubit>()
                            .weightController,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => sl<UserAttributeCubit>()
                          ..fetchUserAttribute(
                              master: "master_shouldertype"),
                        child: BodyItemWidget(
                          title: "Select your shoulder type",
                          selectedId: state.bodyProfile?.shoulderTypeId,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => sl<UserAttributeCubit>()
                          ..fetchUserAttribute(
                              master: "master_bodyposture"),
                        child: BodyItemWidget(
                          title: "Select your body posture",
                          selectedId: state.bodyProfile?.bodyPostureId,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => sl<UserAttributeCubit>()
                          ..fetchUserAttribute(
                              master: "master_bodyshape"),
                        child: BodyItemWidget(
                          title: "Select your body shape",
                          selectedId: state.bodyProfile?.bodyShapeId,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BlocProvider(
                        create: (context) => sl<UserAttributeCubit>()
                          ..fetchUserAttribute(
                              master: "master_fitpreference"),
                        child: BodyItemWidget(
                          title: "Select your fit preference",
                          selectedId: state.bodyProfile?.fitPreferenceId,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 6.h,
          margin: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          child: PrimaryGradientButton(
              title: "Proceed",
              onPressed: () {
                final user =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user;
                context.read<BodyProfileCubit>().saveBodyProfile(
                    user: user, isFeet: selectedHeightCat == "feet");
              })),
    );
  }
}
