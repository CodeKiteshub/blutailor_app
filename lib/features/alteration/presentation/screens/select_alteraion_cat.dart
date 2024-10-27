import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SelectAlteraionCat extends StatefulWidget {
  const SelectAlteraionCat({super.key});

  @override
  State<SelectAlteraionCat> createState() => _SelectAlteraionCatState();
}

class _SelectAlteraionCatState extends State<SelectAlteraionCat> {
  SelectedCatModel? selectedCat;

  @override
  void initState() {
    context.read<CategoryCubit>().fetchGarmentUseCase();
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
                "Alteration",
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
                    left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select the garment you want altered",
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
                                        selectedCat = SelectedCatModel(
                                            id: state.categories[index].id,
                                            img: state.categories[index].image,
                                            label:
                                                state.categories[index].label);
                                        setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(0.5.h),
                                            decoration: BoxDecoration(
                                              gradient: selectedCat?.id ==
                                                      state.categories[index].id
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(title: "Proceed", onPressed: () {
          if (selectedCat != null) {
            Navigator.pushNamed(context, '/alteration-option',
                arguments: selectedCat);
          } else {
            PrimarySnackBar(context, "Please select a garment", Colors.red);
          }
        }),
      ),
    );
  }
}
