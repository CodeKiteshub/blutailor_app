import 'package:bluetailor_app/common/cubit/size_chart/size_chart_cubit.dart';
import 'package:bluetailor_app/common/standard_styling_data.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/gradient_text.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:bluetailor_app/common/cubit/styling_cubit/styling_cubit.dart';
import 'package:bluetailor_app/common/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/features/custom_made/presentation/cubit/product_cubit.dart';
import 'package:bluetailor_app/features/custom_made/presentation/widgets/custom_sizing_dialog.dart';
import 'package:bluetailor_app/common/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ProductDetails extends StatefulWidget {
  final ProductEntities product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isCustom = false;
  List<String> categoryList = [
    "5e6c843c3a2df13444183298",
    "5e6c845a3a2df13444183299",
    "636f3012feea0816508c5c45",
    "65d0cb5c77b0fedc13f0dae7",
    "5da7220571762c2a58b27a6b"
  ];

  @override
  void initState() {
    BlocProvider.of<StylingCubit>(context)
        .fetchStyling(catId: widget.product.catId);
    context.read<SizeChartCubit>().fetchSizeChart(catId: widget.product.catId);
    context.read<BodyProfileCubit>().fetchUserSize(catId: widget.product.catId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.product.images.firstOrNull ?? emtyImage,
                    height: 30.h,
                    width: 100.w,
                  ),
                  Positioned(
                    top: 2.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            backIcon,
                            color: primaryBlue,
                            height: 2.5.h,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Product Details",
                          style: TextStyle(
                              color: primaryBlue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: TextStyle(
                          color: const Color(0xFF323232),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text.rich(
                      TextSpan(
                          text: "₹" + widget.product.price.toString() + "/-",
                          style: TextStyle(
                              color: primaryBlue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " incl. of all taxes",
                              style: TextStyle(
                                  color: const Color(0xFF323232),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                          color: const Color(0xFF7D7D7D),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Divider(
                thickness: 1.h,
                color: const Color(0xFFE3E3E3),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GradientText(text: "Sizing"),
                    SizedBox(
                      height: 2.h,
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
                                                horizontal: 16, vertical: 12)
                                            : const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: context
                                                        .read<
                                                            BodyProfileCubit>()
                                                        .selectedSize ==
                                                    state.sizeChart[index].size
                                                ? primaryBlue
                                                : Colors.white,
                                            border:
                                                Border.all(color: primaryBlack),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          state.sizeChart[index].size,
                                          style: TextStyle(
                                              fontFamily: "dmsans",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.sp,
                                              color: context
                                                          .read<
                                                              BodyProfileCubit>()
                                                          .selectedSize ==
                                                      state
                                                          .sizeChart[index].size
                                                  ? Colors.white
                                                  : primaryBlack),
                                        ),
                                      ),
                                    )),
                          );
                        }

                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Wrap(
                            spacing: 3.w,
                            runSpacing: 0.5.h,
                            children: List.generate(
                                10,
                                (index) => Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "4",
                                        style: TextStyle(
                                          fontFamily: "dmsans",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    )),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Want it tailored to your exact size?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: const Color(0xFF49454F)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          sl<UserAttributeCubit>()
                                            ..fetchUserAttribute(
                                                master: "master_fitpreference"),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          sl<BodyProfileCubit>(),
                                    ),
                                  ],
                                  child: const CustomSizingDialog(),
                                ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.5.h),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Create Custom Sizing",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Divider(
                thickness: 1.h,
                color: const Color(0xFFE3E3E3),
              ),
              SizedBox(
                height: 2.h,
              ),
              categoryList.contains(widget.product.catId)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          const GradientText(text: "Styling"),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  isCustom = false;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color:
                                          isCustom ? Colors.white : primaryBlue,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4)
                                      ]),
                                  child: Text(
                                    "Standard",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color:
                                            isCustom ? black2 : Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  isCustom = true;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color:
                                          isCustom ? primaryBlue : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4)
                                      ]),
                                  child: Text(
                                    "Custom",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color:
                                            isCustom ? Colors.white : black2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          if (!isCustom)
                            MasonryGridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: 2.h,
                                crossAxisSpacing: 3.w,
                                itemCount: ((standardJson["categories"] as List)
                                            .firstWhere((e) =>
                                                e["id"] ==
                                                widget.product
                                                    .catId)["defaultConfig"]
                                        as List)
                                    .length,
                                itemBuilder: (context, index) {
                                  final standard = ((standardJson["categories"]
                                              as List)
                                          .firstWhere((e) =>
                                              e["id"] == widget.product.catId)[
                                      "defaultConfig"] as List)[index];
                                  return Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryBlue))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GradientText(text: standard["label"]),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          standard["name"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: black2),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          else
                            BlocBuilder<StylingCubit, StylingState>(
                                builder: (context, state) {
                              if (context
                                  .read<StylingCubit>()
                                  .selectedStylingList
                                  .isEmpty) {
                                return Column(
                                  children: [
                                    Text(
                                      'No Styling Found. Tap on the button below to add styling',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: const Color(0xFF49454F)),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/custom_filter",
                                            arguments: context
                                                .read<StylingCubit>()
                                                .customStyling);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4)
                                            ]),
                                        child: Text(
                                          "Add Styling",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    MasonryGridView.count(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 2.h,
                                        crossAxisSpacing: 3.w,
                                        itemCount: context
                                            .read<StylingCubit>()
                                            .selectedStylingList
                                            .length,
                                        itemBuilder: (context, index) {
                                          final custom = context
                                              .read<StylingCubit>()
                                              .selectedStylingList[index];
                                          return Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: primaryBlue))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GradientText(text: custom.name),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text(
                                                  custom.label,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp,
                                                      color: black2),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/custom_filter",
                                            arguments: context
                                                .read<StylingCubit>()
                                                .customStyling);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4)
                                            ]),
                                        child: Text(
                                          "Edit Styling",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }
                            }),
                        ],
                      ),
                    ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductAddedToCart) {
              Navigator.pop(context);
              PrimarySnackBar(context, "Added to cart", Colors.green);
            }
            if (state is ProductError) {
              Navigator.pop(context);
              PrimarySnackBar(context, "Something went wrong", Colors.red);
            }
            if (state is ProductLoading) {
              LoadingDialog(context);
            }
          },
          child: PrimaryGradientButton(
              title: "Add to Cart",
              onPressed: () {
                if (isCustom) {
                  context.read<ProductCubit>().addProductToCart(
                      catId: widget.product.catId,
                      deliveryDays: widget.product.deliveryDays,
                      disc: widget.product.disc,
                      discPrice: widget.product.discPrice,
                      isPer: widget.product.isPer,
                      price: widget.product.price,
                      name: widget.product.name,
                      itemId: widget.product.id,
                      images: widget.product.images,
                      producttypeId: widget.product.producttypeId,
                      styles: categoryList.contains(widget.product.catId)
                          ? []
                          : context.read<StylingCubit>().selectedStylingList);
                } else {
                  context.read<ProductCubit>().addProductToCart(
                      catId: widget.product.catId,
                      deliveryDays: widget.product.deliveryDays,
                      disc: widget.product.disc,
                      discPrice: widget.product.discPrice,
                      isPer: widget.product.isPer,
                      price: widget.product.price,
                      name: widget.product.name,
                      itemId: widget.product.id,
                      images: widget.product.images,
                      producttypeId: widget.product.producttypeId,
                      styles: categoryList.contains(widget.product.catId)
                          ? []
                          : ((standardJson["categories"] as List).firstWhere(
                                      (e) => e["id"] == widget.product.catId)[
                                  "defaultConfig"] as List)
                              .map((e) => SelectedStylingEntity(
                                  catTag: e["masterName"],
                                  name: e['name'],
                                  label: e["label"],
                                  value: e["value"]))
                              .toList());
                }
              }),
        ),
      ),
    );
  }
}
