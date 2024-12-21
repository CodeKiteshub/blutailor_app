import 'package:bluetailor_app/common/models/product_config_model.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/alteration_config/alteration_config_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/user_measurement/user_measurement_cubit.dart';
import 'package:bluetailor_app/features/alteration/presentation/widgets/alteration_config_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class AlterationDetails extends StatefulWidget {
  final SelectedCatModel selectedCat;
  final String imgFile;
  final String videoFile;
  const AlterationDetails(
      {super.key,
      required this.selectedCat,
      required this.imgFile,
      required this.videoFile});

  @override
  State<AlterationDetails> createState() => _AlterationDetailsState();
}

class _AlterationDetailsState extends State<AlterationDetails> {
  @override
  void initState() {
    context
        .read<AlterationConfigCubit>()
        .fetchConfig(catId: widget.selectedCat.id);
    context
        .read<AlterationUserMeasurementCubit>()
        .fetchUserMeasurement(catId: widget.selectedCat.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Alteration"),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(
                left: 7.w,
                right: 7.w,
                top: 3.h,
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Customize your shirt to meet your exact preferences",
                          style: TextStyle(
                              color: const Color(0xFF383A3A),
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp)),
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<AlterationConfigCubit, AlterationConfigState>(
                        builder: (context, state) {
                          if (state is AlterationConfigLoaded) {
                            return BlocBuilder<AlterationUserMeasurementCubit,
                                UserMeasurementState>(
                              builder: (context, userMeasurement) {
                                if (userMeasurement is UserMeasurementLoaded) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                      itemCount: state.config.length,
                                      itemBuilder: (context, index) =>
                                          AlterationConfigWidget(
                                            name: state.config[index].name,
                                            title: state.config[index].label,
                                            price: state.config[index].price,
                                            measurementData: userMeasurement
                                                .userAttributes
                                                .firstWhere(
                                                    (element) =>
                                                        element.name ==
                                                        state.config[index]
                                                            .label.toString().replaceAll(" ", "_"),
                                                    orElse: () => Option(
                                                        label: "", value: 0))
                                                .value
                                                .toDouble(),
                                          ));
                                } else {
                                  return Center(
                                    child: LoadingAnimationWidget.beat(
                                        color: primaryBlue, size: 50),
                                  );
                                }
                              },
                            );
                          } else {
                            return Center(
                              child: LoadingAnimationWidget.beat(
                                  color: primaryBlue, size: 50),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SizedBox(
                        height: 8.h,
                      )
                    ]),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(
            title: "Proceed",
            onPressed: () {
              Navigator.pushNamed(context, '/alteration-order-summary',
                  arguments: {
                    "selectedCat": widget.selectedCat,
                    "imgFile": widget.imgFile,
                    "videoFile": widget.videoFile,
                    "alterations":
                        context.read<AlterationConfigCubit>().alterations
                  });
            }),
      ),
    );
  }
}
