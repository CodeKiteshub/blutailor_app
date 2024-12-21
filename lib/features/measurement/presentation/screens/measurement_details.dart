import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/models/product_config_model.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/measurement/measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/product_config/product_config_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/measurement/presentation/widget/measurement_data_widget.dart';
import 'package:bluetailor_app/common/widgets/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class MeasurementDetails extends StatefulWidget {
  final SelectedCatModel selectedCat;
  const MeasurementDetails({super.key, required this.selectedCat});

  @override
  State<MeasurementDetails> createState() => _MeasurementDetailsState();
}

class _MeasurementDetailsState extends State<MeasurementDetails> {
  String videoUrl = "";
  bool isInch = true;

  @override
  void initState() {
    context
        .read<ProductConfigCubit>()
        .fetchProductConfig(catId: widget.selectedCat.id);
    context
        .read<UserMeasurementCubit>()
        .fetchUserMeasurement(catId: widget.selectedCat.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(
        title: "Measurements (Custom)",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
          top: 3.h,
        ),
        child: BlocBuilder<UserMeasurementCubit, UserMeasurementState>(
          builder: (context, userMeasurementState) {
            if (userMeasurementState is UserMeasurementLoaded) {
              return BlocBuilder<ProductConfigCubit, ProductConfigState>(
                builder: (context, state) {
                  if (state is ProductConfigLoaded) {
                    if (videoUrl.isEmpty) {
                      videoUrl = state.productConfig.isEmpty
                          ? ""
                          : state.productConfig.first.videoUrl!.split("/").last;
                    }
                    return ListView(
                      children: [
                        Text("${widget.selectedCat.label} Details",
                            style: TextStyle(
                                color: primaryBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text.rich(
                          TextSpan(
                              text: "Step by step ",
                              style: TextStyle(
                                color: primaryBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: widget.selectedCat.label,
                                  style: TextStyle(
                                    color: const Color(0XFF39DBED),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: " measurement guide",
                                  style: TextStyle(
                                    color: primaryBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                  ),
                                )
                              ]),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        videoUrl == ""
                            ? const SizedBox.shrink()
                            : YoutubePlayerWidget(
                                key: ValueKey(videoUrl),
                                videoId: videoUrl,
                              ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                                value: true,
                                groupValue: isInch,
                                onChanged: (value) {
                                  setState(() {
                                    isInch = value!;
                                  });
                                }),
                            Text(
                              "Inches (in)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff3b3a3a),
                                  fontSize: 15.sp),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Radio(
                                value: false,
                                groupValue: isInch,
                                onChanged: (value) {
                                  setState(() {
                                    isInch = value!;
                                  });
                                }),
                            Text(
                              "Centimeters (cm)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff3b3a3a),
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MasonryGridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 2.h,
                            crossAxisSpacing: 3.w,
                            itemCount: state.productConfig.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (videoUrl !=
                                      state.productConfig[index].videoUrl!
                                          .split("/")
                                          .last) {
                                    videoUrl = state
                                        .productConfig[index].videoUrl!
                                        .split("/")
                                        .last;

                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: videoUrl ==
                                                  state.productConfig[index]
                                                      .videoUrl!
                                                      .split("/")
                                                      .last
                                              ? primaryBlue
                                              : Colors.transparent)),
                                  child: MeasurementDataWidget(
                                    previouesValue: userMeasurementState
                                        .userAttributes
                                        .firstWhere(
                                            (element) =>
                                                element.label ==
                                                state
                                                    .productConfig[index].label,
                                            orElse: () =>
                                                Option(label: "", value: 0))
                                        .value
                                        .toString(),
                                    title: state.productConfig[index].label,
                                    isInch: isInch,
                                    cmController: context
                                        .read<ProductConfigCubit>()
                                        .answers
                                        .firstWhere((element) =>
                                            element.label ==
                                            state.productConfig[index].label)
                                        .cmController,
                                    inchController: context
                                        .read<ProductConfigCubit>()
                                        .answers
                                        .firstWhere((element) =>
                                            element.label ==
                                            state.productConfig[index].label)
                                        .inchController,
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    );
                  }
                  return LoadingAnimationWidget.beat(
                      color: primaryBlue, size: 50);
                },
              );
            }
            return LoadingAnimationWidget.beat(color: primaryBlue, size: 50);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 6.h,
          margin: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          child: BlocListener<MeasurementCubit, MeasurementState>(
            listener: (context, state) {
              if (state is MeasurementLoading) {
                LoadingDialog(context);
              }
              if (state is MeasurementError) {
                PrimarySnackBar(context, state.message, Colors.red);
                Navigator.pop(context);
              }
              if (state is MeasurementSaved) {
                PrimarySnackBar(context, state.message, Colors.green);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: PrimaryGradientButton(
                title: "Save and Continue",
                onPressed: () {
                  context.read<MeasurementCubit>().saveMeasurement(
                    catId: widget.selectedCat.id,
                    subCat: (context.read<ProductConfigCubit>().state
                            as ProductConfigLoaded)
                        .subCat,
                    options: [
                      ...context
                          .read<ProductConfigCubit>()
                          .answers
                          .map((e) => e.toJson())
                    ],
                  );
                }),
          )),
    );
  }
}
