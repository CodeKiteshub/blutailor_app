import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/address_box_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/place_order_cubit/place_order_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/price_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartCubit>().fetchCart();
    context.read<AddressCubit>().fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Cart"),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
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
                    CartItemWidget(
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
                            if (state.addressStatus == AddressStatus.loaded) {
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
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Add Coupon",
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.27),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                                border: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFBEBEBE))),
                                suffix: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        PriceBoxWidget(
                          cart: state.cart,
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
          } else {
            return Center(
              child: LoadingAnimationWidget.beat(color: primaryBlue, size: 50),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return state is CartLoaded && state.cart.items.isNotEmpty
                ? BlocListener<PlaceOrderCubit, PlaceOrderState>(
                    listener: (context, state) {
                      if (state is PlaceOrderLoading) {
                        LoadingDialog(context);
                      }
                      if (state is PlaceOrderSuccess) {
                        Navigator.pop(context);
                        context.read<CartCubit>().fetchCart();
                        PrimarySnackBar(context, "Your order has been placed",
                            Colors.green);
                      }
                      if (state is PlaceOrderError) {
                        Navigator.pop(context);
                        PrimarySnackBar(
                            context, "Something went wrong", Colors.red);
                      }
                    },
                    child: PrimaryGradientButton(
                        title: "Proceed to Payment Portal",
                        onPressed: () {
                          DefaultDialog(context,
                              title: "Cart",
                              message: "What you want to do with your cart?",
                              cancelText: "Alteration",
                              confirmText: "Stitching", onCancel: () {
                            Navigator.pop(context);

                            final user = (context.read<AppUserCubit>().state
                                    as AppUserLoggedIn)
                                .user;
                            final addressId =
                                (context.read<AddressCubit>().state)
                                    .addresses!
                                    .elementAt(context
                                        .read<AddressCubit>()
                                        .selectedAddress)
                                    .id;
                            final cartId =
                                (context.read<CartCubit>().state as CartLoaded)
                                    .cart
                                    .id;
                            final amount =
                                (context.read<CartCubit>().state as CartLoaded)
                                    .cart
                                    .gTotal;
                            context
                                .read<PlaceOrderCubit>()
                                .placeAlterationOrder(
                                    addressId: addressId!,
                                    cartId: cartId,
                                    user: user,
                                    amount: (amount * 100).toString());
                          }, onConfirm: () {
                            Navigator.pop(context);
                            final user = (context.read<AppUserCubit>().state
                                    as AppUserLoggedIn)
                                .user;
                            final addressId =
                                (context.read<AddressCubit>().state)
                                    .addresses!
                                    .elementAt(context
                                        .read<AddressCubit>()
                                        .selectedAddress)
                                    .id;
                            final cartId =
                                (context.read<CartCubit>().state as CartLoaded)
                                    .cart
                                    .id;
                            final amount =
                                (context.read<CartCubit>().state as CartLoaded)
                                    .cart
                                    .gTotal;
                            context
                                .read<PlaceOrderCubit>()
                                .placeAlterationOrder(
                                    addressId: addressId!,
                                    cartId: cartId,
                                    user: user,
                                    amount: (amount * 100).toString());
                          });
                        }),
                  )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
