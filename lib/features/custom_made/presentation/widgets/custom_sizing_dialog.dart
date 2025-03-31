import 'dart:ui';

import 'package:bluetailor_app/common/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/gradient_text.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/common/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CustomSizingDialog extends StatefulWidget {
  const CustomSizingDialog({super.key});

  @override
  State<CustomSizingDialog> createState() => _CustomSizingDialogState();
}

class _CustomSizingDialogState extends State<CustomSizingDialog> {
  String? selectedAttribute;

  @override
  void initState() {
    context.read<BodyProfileCubit>().fetchBodyProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const GradientText(
                      text: "Custom Sizing",
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                PrimaryTextField(
                    title: "Height",
                    border: true,
                    suffixText: "cm",
                    controller: context.read<BodyProfileCubit>().cmController),
                SizedBox(
                  height: 1.h,
                ),
                PrimaryTextField(
                    title: "Weight",
                    border: true,
                    suffixText: "kgs",
                    controller:
                        context.read<BodyProfileCubit>().weightController),
                SizedBox(
                  height: 1.h,
                ),
                PrimaryTextField(
                    title: "Age",
                    border: true,
                    suffixText: "years",
                    controller: context.read<BodyProfileCubit>().ageController),
                SizedBox(
                  height: 1.h,
                ),
                BlocBuilder<UserAttributeCubit, UserAttributeState>(
                  builder: (context, state) {
                    if (state is UserAttributeLoaded) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xFFC7C7C7))),
                        child: DropdownButton(
                            items: state.userAttributes
                                .map((e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.name,
                                      style: TextStyle(fontSize: 16.sp),
                                    )))
                                .toList(),
                            isExpanded: true,
                            underline: Container(),
                            value: selectedAttribute,
                            hint: Text(
                              "Fit Type",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            borderRadius: BorderRadius.circular(5),
                            dropdownColor: Colors.white,
                            onChanged: (value) {
                              selectedAttribute = value as String;

                              BlocProvider.of<BodyProfileCubit>(context)
                                  .fitPreferenceId = selectedAttribute;
                              setState(() {});
                            }),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocListener<BodyProfileCubit, BodyProfileState>(
                  listener: (context, state) {
                    if (state.status == BodyProfileStatus.saved) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      PrimarySnackBar(
                          context, "Body Profile Updated", Colors.green);
                    }
                    if (state.status == BodyProfileStatus.error) {
                      Navigator.pop(context);
                      PrimarySnackBar(
                          context, "Something went wrong.", Colors.red);
                    }
                    if (state.status == BodyProfileStatus.loading) {
                      LoadingDialog(context);
                    }
                  },
                  child: PrimaryGradientButton(
                    title: "Submit",
                    onPressed: () {
                      final user = (context.read<AppUserCubit>().state
                              as AppUserLoggedIn)
                          .user;
                      context
                          .read<BodyProfileCubit>()
                          .saveBodyProfile(user: user, isFeet: false);
                    },
                  ),
                ),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
