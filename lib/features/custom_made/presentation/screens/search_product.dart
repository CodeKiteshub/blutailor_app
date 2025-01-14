import 'dart:async';

import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/search_box_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/custom_made/presentation/cubit/product_cubit.dart';
import 'package:bluetailor_app/features/custom_made/presentation/widgets/product_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SearchProduct extends StatefulWidget {
  final String id;
  const SearchProduct({super.key, required this.id});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
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
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
              child: Text(
                "Search for your desired products and services",
                style: TextStyle(
                    color: grey, fontSize: 15.sp, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: SearchBoxWidget(
                  enabled: true,
                  onChanged: (p0) {
                    // Cancel the previous timer to avoid overlapping API calls
                    _debounceTimer?.cancel();

                    // Set a new timer for the debounce period (e.g., 500 milliseconds)
                    _debounceTimer =
                        Timer(const Duration(milliseconds: 100), () {
                      // Perform the API call here using the searchText variable
                      // Call your API function to fetch the address data
                      // Example:
                      context.read<ProductCubit>().fetchProducts(
                          page: 1, catId: widget.id, searchTerm: p0);
                    });
                  },
                )),
            SizedBox(
              height: 2.h,
            ),
            Divider(thickness: 1.h, color: const Color(0xFFE3E3E3)),
            SizedBox(
              height: 2.h,
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded && state.products.isEmpty ||
                    state is ProductInitial) {
                  return const SizedBox.shrink();
                }
                if (state is ProductError) {
                  return const SizedBox.shrink();
                  
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Text("Search results",
                          style: TextStyle(
                              color: const Color(0xFFAEAEAE),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400)),
                    ),
                    SizedBox(height: 1.h),
                    if (state is ProductLoaded)
                      MasonryGridView.count(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 2.h,
                          crossAxisSpacing: 2.h,
                          crossAxisCount: 2,
                          itemCount: state.products.length,
                          itemBuilder: (context, index) => ProductBox(
                                product: state.products[index],
                              ))
                    else
                      Shimmer.fromColors(
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
                            itemBuilder: (context, index) =>
                                const ProductBox()),
                      ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Divider(thickness: 1.h, color: const Color(0xFFE3E3E3)),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Text("Recommended Products",
                  style: TextStyle(
                      color: const Color(0xFFAEAEAE),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 1.h),
            MasonryGridView.count(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 2.h,
                crossAxisCount: 2,
                itemCount: 2,
                itemBuilder: (context, index) => const ProductBox()),
          ],
        ),
      ),
    );
  }
}
