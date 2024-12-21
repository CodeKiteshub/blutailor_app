import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_stitching_cat_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SelectStitchingCat extends StatefulWidget {
  const SelectStitchingCat({super.key});

  @override
  State<SelectStitchingCat> createState() => _SelectStitchingCatState();
}

class _SelectStitchingCatState extends State<SelectStitchingCat> {
  List<SelectedStitchingCatEntity> selectedCat = [];

  @override
  void initState() {
    context.read<CategoryCubit>().fetchGarmentUseCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(
        title: "Stitching",
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select the garment you want to get stitched ",
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
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 5.w / 3.h),
                        padding: EdgeInsets.only(top: 3.h),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: state.categories[index].image,
                                      height: 15.h,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Text(
                                      state.categories[index].label,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: primaryBlue),
                                    ),
                                    SizedBox(height: 0.5.h,),
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (selectedCat.any((e) =>
                                                  e.id ==
                                                  state.categories[index].id)) {
                                                if (selectedCat
                                                        .firstWhere((e) =>
                                                            e.id ==
                                                            state
                                                                .categories[
                                                                    index]
                                                                .id)
                                                        .length >
                                                    0) {
                                                  selectedCat
                                                      .firstWhere((e) =>
                                                          e.id ==
                                                          state
                                                              .categories[index]
                                                              .id)
                                                      .length--;
                                                } else {
                                                  selectedCat
                                                      .removeWhere((e) =>
                                                          e.id ==
                                                          state
                                                              .categories[index]
                                                              .id);
                                                }
                                              }
                                              setState(() {
                                                
                                              });
                                            },
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFF5F3F3)),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 18.sp,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Container(
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xFFD9D9D9)),
                                              child: Text(selectedCat.any((e) =>
                                                          e.id ==
                                                          state
                                                              .categories[index]
                                                              .id) ==
                                                      true
                                                  ? selectedCat
                                                      .firstWhere((e) =>
                                                          e.id ==
                                                          state
                                                              .categories[index]
                                                              .id)
                                                      .length
                                                      .toString()
                                                  : "0")),
                                          InkWell(
                                            onTap: () {
                                              if (selectedCat.any((e) =>
                                                  e.id ==
                                                  state.categories[index].id)) {
                                                selectedCat
                                                    .firstWhere((e) =>
                                                        e.id ==
                                                        state.categories[index]
                                                            .id)
                                                    .length++;
                                              } else {
                                                selectedCat.add(
                                                    SelectedStitchingCatEntity(
                                                        id: state
                                                            .categories[index]
                                                            .id,
                                                        label: state
                                                            .categories[index]
                                                            .label,
                                                        img: state
                                                            .categories[index]
                                                            .image,
                                                        length: 1));
                                              }
                                              setState(() {
                                                
                                              });
                                            },
                                            child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFF5F3F3)),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 18.sp,
                                                  color: Colors.black,
                                                )),
                                          ),
                                        ])
                                  ],
                                ),
                              ],
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
              Navigator.pushNamed(context, "/selected-stitching-cat", arguments: selectedCat);
            }),
      ),
    );
  }
}