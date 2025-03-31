import 'package:bluetailor_app/common/widgets/address_box_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/product_cart_cubit/product_cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/price_box_widget.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/product_cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ProductCartWidget extends StatefulWidget {
  const ProductCartWidget({super.key});

  @override
  State<ProductCartWidget> createState() => _ProductCartWidgetState();
}

class _ProductCartWidgetState extends State<ProductCartWidget> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCartCubit, ProductCartState>(
        builder: (context, state) {
          if (state is ProductCartLoaded) {
            if (state.cart.items.isEmpty) {
              return Center(
                  child: Text(
                "Cart is empty",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
              ));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    ProductCartItemWidget(
                      cartItem: state.cart.items,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Divider(thickness: 3.h, color: const Color(0xFFE3E3E3)),
                    SizedBox(
                      height: 3.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text.rich(TextSpan(
                        //     text: "Your order is expected to be delivered by ",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 16.sp,
                        //         color: black2),
                        //     children: [
                        //       TextSpan(
                        //           text: "",
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w700,
                        //               fontSize: 16.sp,
                        //               color: primaryRed))
                        //     ])),
                        BlocBuilder<AddressCubit, AddressState>(
                          builder: (context, state) {
                            if (state.addressStatus == AddressStatus.loaded &&
                                state.addresses!.isNotEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: AddressBoxWidget(
                                  address: state.addresses!.elementAt(context
                                      .read<AddressCubit>()
                                      .selectedAddress),
                                  changeAddress: true,
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: const EmptyAddressBox(),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: TextField(
                            controller: _couponController,
                            decoration: InputDecoration(
                                hintText: "Add Coupon",
                                hintStyle: TextStyle(
                                    color: Colors.black.withValues(alpha: 0.27),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFBEBEBE))),
                                suffix: InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductCartCubit>()
                                        .validateCoupon(
                                            code: _couponController.text);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: primaryBlue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        PriceBoxWidget(
                          gTotal: state.cart.gTotal,
                          total: state.cart.totalAmount,
                          discTotal: state.cart.discTotal,
                        ),
                        SizedBox(
                          height: 13.h,
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          } else if (state is ProductCartLoading) {
            return Center(
              child: LoadingAnimationWidget.beat(color: primaryBlue, size: 50),
            );
          } else {
            return Center(
                child: Text(
              "Cart is empty",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp),
            ));
          }
        },
      ),
    );
  }
}
