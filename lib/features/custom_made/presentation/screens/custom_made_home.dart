import 'package:bluetailor_app/common/cubit/category_cubit/category_cubit.dart';
import 'package:bluetailor_app/common/widgets/gradient_text.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/custom_made/presentation/cubit/product_cubit.dart';
import 'package:bluetailor_app/features/custom_made/presentation/widgets/product_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomMadeHome extends StatefulWidget {
  const CustomMadeHome({super.key});

  @override
  State<CustomMadeHome> createState() => _CustomMadeHomeState();
}

class _CustomMadeHomeState extends State<CustomMadeHome> {
  @override
  void initState() {
    context.read<CategoryCubit>().fetchGarmentUseCase(false, false);
    context.read<ProductCubit>().fetchProducts(page: 1, catId: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Custom Made"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 3.h,
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return SizedBox(
                    height: 14.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/product-cat-details',
                              arguments: {
                                "title": state.categories[index].label,
                                "id": state.categories[index].id
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 10.h,
                              width: 10.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        state.categories[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15.sp)),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              state.categories[index].label,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15.sp),
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 3.w),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            Image.asset(
              customMadeTop,
              width: 100.w,
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: const GradientText(text: "New Arrivals"),
            ),
            SizedBox(
              height: 2.h,
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      mainAxisSpacing: 2.h,
                      crossAxisSpacing: 2.h,
                      crossAxisCount: 2,
                      itemCount: 4,
                      itemBuilder: (context, index) => ProductBox(
                            product: state.products[index],
                          ));
                } else {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: MasonryGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        mainAxisSpacing: 2.h,
                        crossAxisSpacing: 2.h,
                        crossAxisCount: 2,
                        itemCount: 4,
                        itemBuilder: (context, index) => const ProductBox()),
                  );
                }
              },
            ),
            SizedBox(
              height: 3.h,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.w, right: 5.w),
            //   child: const GradientText(text: "Recently Browsed"),
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // MasonryGridView.count(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     padding: EdgeInsets.only(left: 5.w, right: 5.w),
            //     mainAxisSpacing: 2.h,
            //     crossAxisSpacing: 2.h,
            //     crossAxisCount: 2,
            //     itemCount: 2,
            //     itemBuilder: (context, index) => const ProductBox()),
            // SizedBox(
            //   height: 3.h,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child:
                  PrimaryGradientButton(title: "View More", onPressed: () {}),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: const GradientText(text: "Explore"),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-cat-details',
                            arguments: {
                              "title": "Trousers",
                              "id": "5da7220571762c2a58b27a67"
                            });
                      },
                      child: Stack(
                        children: [
                          Image.asset("assets/images/custom_made_trouser.png"),
                          Positioned(
                            bottom: 2.h,
                            right: 0,
                            left: 0,
                            child: Column(
                              children: [
                                Text("Trousers",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Colors.white)),
                                Text("Shop Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.sp,
                                        color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-cat-details',
                            arguments: {
                              "title": "Sherwanis",
                              "id": "5da7220571762c2a58b27a70"
                            });
                      },
                      child: Stack(
                        children: [
                          Image.asset("assets/images/custom_made_sherwani.png"),
                          Positioned(
                            bottom: 2.h,
                            right: 0,
                            left: 0,
                            child: Column(
                              children: [
                                Text("Sherwanis",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Colors.white)),
                                Text("Shop Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.sp,
                                        color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/product-cat-details',
                      arguments: {
                        "title": "Blazers",
                        "id": "5da7220571762c2a58b27a68"
                      });
                },
                child: Stack(
                  children: [
                    Image.asset("assets/images/custom_made_blazer.png"),
                    Positioned(
                      bottom: 2.h,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Text("Blazers",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white)),
                          Text("Shop Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.sp,
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}
