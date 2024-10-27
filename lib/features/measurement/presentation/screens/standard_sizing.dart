import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/size_chart/size_chart_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class StandardSizing extends StatefulWidget {
  final String catId;
  const StandardSizing({super.key, required this.catId});

  @override
  State<StandardSizing> createState() => _StandardSizingState();
}

class _StandardSizingState extends State<StandardSizing> {
  String selectedHeightCat = "feet";

  @override
  void initState() {
    context.read<BodyProfileCubit>().fetchUserSize(catId: widget.catId);
    context
        .read<UserAttributeCubit>()
        .fetchUserAttribute(master: "master_fitpreference");
    context.read<SizeChartCubit>().fetchSizeChart(catId: widget.catId);
    context.read<BodyProfileCubit>().fetchBodyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
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
              height: 2.h,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
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
                      Navigator.pop(context);
                    }
                    if (state.status == BodyProfileStatus.loading) {
                      LoadingDialog(context);
                    }
                  },
                  builder: (context, state) {
                    if (state.status == BodyProfileStatus.loading) {
                      return LoadingAnimationWidget.beat(
                          color: primaryBlue, size: 50);
                    }
                    return ListView(
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
                          "Select Sizing",
                          style: TextStyle(
                            color: const Color(0xFF757575),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        BlocBuilder<SizeChartCubit, SizeChartState>(
                          builder: (context, state) {
                            if (state is SizeChartLoaded) {
                              return Wrap(
                                spacing: 3.w,
                                runSpacing: 0.5.h,
                                children: List.generate(
                                    state.sizeChart.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            context
                                                    .read<BodyProfileCubit>()
                                                    .selectedSize =
                                                state.sizeChart[index].size;
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: state.sizeChart[index].size
                                                        .length ==
                                                    1
                                                ? const EdgeInsets.symmetric(
                                                    horizontal: 11.5,
                                                    vertical: 8)
                                                : const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: context
                                                            .read<
                                                                BodyProfileCubit>()
                                                            .selectedSize ==
                                                        state.sizeChart[index]
                                                            .size
                                                    ? primaryBlue
                                                    : Colors.white,
                                                border: Border.all(
                                                    color: primaryBlack),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              state.sizeChart[index].size,
                                              style: TextStyle(
                                                  fontFamily: "dmsans",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.sp,
                                                  color: context
                                                              .read<
                                                                  BodyProfileCubit>()
                                                              .selectedSize ==
                                                          state.sizeChart[index]
                                                              .size
                                                      ? Colors.white
                                                      : primaryBlack),
                                            ),
                                          ),
                                        )),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
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
                          controller:
                              context.read<BodyProfileCubit>().ageController,
                        ),
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
                              padding: EdgeInsets.only(left: 3.w, right: 3.w),
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
                                              color: const Color(0xff444444)),
                                        )),
                                    DropdownMenuItem(
                                        value: "cm",
                                        child: Text(
                                          "Centimeter",
                                          style: TextStyle(
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                              color: const Color(0xff444444)),
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
                          controller:
                              context.read<BodyProfileCubit>().weightController,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Fit Type",
                          style: TextStyle(
                            color: const Color(0xFF757575),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              fontFamily: "dmsans"),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        BlocBuilder<UserAttributeCubit, UserAttributeState>(
                          builder: (context, state) {
                            if (state is UserAttributeLoaded) {
                              return Container(
                                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                                constraints: BoxConstraints(minHeight: 6.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffc7c7c7)),
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButton<String>(
                                  items: List.generate(
                                      state.userAttributes.length,
                                      (index) => DropdownMenuItem(
                                            value:
                                                state.userAttributes[index].id,
                                            child: Text(
                                              state.userAttributes[index].name,
                                              style: TextStyle(
                                                  fontFamily: 'dmsans',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.sp,
                                                  color:
                                                      const Color(0xff444444)),
                                            ),
                                          )),
                                  hint: Text(
                                    "Select Preference",
                                    style: TextStyle(
                                        fontFamily: 'dmsans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: const Color(0xff444444)),
                                  ),
                                  value: context
                                      .read<BodyProfileCubit>()
                                      .fitPreferenceId,
                                  onChanged: (value) {
                                    context
                                        .read<BodyProfileCubit>()
                                        .fitPreferenceId = value;
                                    setState(() {});
                                  },
                                  underline: Container(),
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Note",
                          style: TextStyle(
                            color: const Color(0xFF757575),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        TextFormField(
                          controller:
                              context.read<BodyProfileCubit>().noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            constraints: BoxConstraints(
                              minHeight: 6.h,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFC7C7C7)),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: primaryBlue,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
                if (context.read<BodyProfileCubit>().selectedSize.isEmpty) {
                  PrimarySnackBar(context, "Select a size", Colors.red);
                  return;
                }
                if (context.read<BodyProfileCubit>().fitPreferenceId == null) {
                  PrimarySnackBar(
                      context, "Select fit preferences", Colors.red);
                  return;
                }
                final user =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user;
                context.read<BodyProfileCubit>().saveBodyProfile(
                    user: user,
                    isFeet: selectedHeightCat == "feet",
                    catId: widget.catId,
                    size: context.read<BodyProfileCubit>().selectedSize,
                    note: context.read<BodyProfileCubit>().noteController.text);
              })),
    );
  }
}
