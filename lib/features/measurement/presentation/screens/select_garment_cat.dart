
import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SelectGarmentCat extends StatefulWidget {
  final bool fromCustom;
  const SelectGarmentCat({super.key, required this.fromCustom});

  @override
  State<SelectGarmentCat> createState() => _SelectGarmentCatState();
}

class _SelectGarmentCatState extends State<SelectGarmentCat> {
  List<SelectedCatModel> selectedCat = [];

  @override
  void initState() {
    log('Memory usage before dispose: ${(ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2)} MB');
    context.read<CategoryCubit>().fetchGarmentUseCase(false, false);
    log('Memory usage before dispose: ${(ProcessInfo.currentRss / 1024 / 1024).toStringAsFixed(2)} MB');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PrimaryAppBar(
        title: widget.fromCustom ? "Measurements (Custom)" : "Measurements",
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select the garment to upload your measurements",
                style: TextStyle(
                    color: primaryBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: BlocConsumer<CategoryCubit, CategoryState>(
                listener: (context, state) {
                  if (state is CategoryError) {
                    PrimarySnackBar(context, state.message, Colors.red);
                  }
                },
                builder: (context, state) {
                  if (state is CategoryLoaded) {
                    return MasonryGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 2.h,
                        padding: EdgeInsets.only(top: 3.h),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                if (selectedCat.any((element) =>
                                    element.id ==
                                    state.categories[index].id)) {
                                  selectedCat.removeWhere((element) =>
                                      element.id ==
                                      state.categories[index].id);
                                } else {
                                  selectedCat.add(SelectedCatModel(
                                      id: state.categories[index].id,
                                      label: state
                                          .categories[index].label));
                                }
                                setState(() {});
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(0.5.h),
                                    decoration: BoxDecoration(
                                      gradient: selectedCat.any((e) =>
                                              e.id ==
                                              state
                                                  .categories[index].id)
                                          ? borderGradient
                                          : null,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          state.categories[index].image,
                                      height: 15.h,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    state.categories[index].label,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: primaryBlack),
                                  )
                                ],
                              ),
                            ));
                  }
                  return LoadingAnimationWidget.beat(
                      color: Colors.white, size: 50);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(
            title: "Proceed",
            onPressed: () {
              if (widget.fromCustom) {
                Navigator.pushNamed(context, '/body-details',
                    arguments: selectedCat);
              } else {
                if (selectedCat.length == 1) {
                  Navigator.pushNamed(context, '/standard-size',
                      arguments: selectedCat.first.id);
                } else {
                  Navigator.pushNamed(context, '/selected-cat', arguments: {
                    'selectedCat': selectedCat,
                    'fromCustom': widget.fromCustom
                  });
                }
              }
            }),
      ),
    );
  }
}
