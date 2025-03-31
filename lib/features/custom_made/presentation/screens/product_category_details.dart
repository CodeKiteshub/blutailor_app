import 'package:bluetailor_app/common/widgets/gradient_text.dart';
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

class ProductCategoryDetails extends StatefulWidget {
  final String title;
  final String id;
  const ProductCategoryDetails(
      {super.key, required this.title, required this.id});

  @override
  State<ProductCategoryDetails> createState() => _ProductCategoryDetailsState();
}

class _ProductCategoryDetailsState extends State<ProductCategoryDetails> {
  int page = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<ProductCubit>().fetchProducts(page: page, catId: widget.id);
    scrollController.addListener(() {
      setState(() {
        isLoading = true;
      });
      viewMore();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  viewMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      page = page + 1;
      context.read<ProductCubit>().fetchProducts(page: page, catId: widget.id);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Custom Made"),
      body: Padding(
        //  controller: scrollController,
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            GradientText(text: widget.title),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "The latest in our collection of custom designed ${widget.title.toLowerCase()}",
              style: TextStyle(
                  color: grey, fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/search-product",
                      arguments: {"id": widget.id});
                },
                child: const SearchBoxWidget(
                  enabled: false,
                )),
            SizedBox(height: 2.h),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return MasonryGridView.count(
                      controller: scrollController,
                        //   shrinkWrap: true,
                      //  physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 2.h,
                        crossAxisSpacing: 2.h,
                        crossAxisCount: 2,
                        itemCount: state.products.length,
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
                          mainAxisSpacing: 2.h,
                          crossAxisSpacing: 2.h,
                          crossAxisCount: 2,
                          itemCount: 4,
                          itemBuilder: (context, index) => const ProductBox()),
                    );
                  }
                },
              ),
            ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // isLoading == true
            //     ? const Center(child: CircularProgressIndicator())
            //     : const SizedBox.shrink(),
            // SizedBox(
            //   height: 2.h,
            // )
          ],
        ),
      ),
    );
  }
}
