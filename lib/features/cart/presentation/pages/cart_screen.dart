import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/place_order_cubit/place_order_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/product_cart_cubit/product_cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/product_cart_widget.dart';
import 'package:bluetailor_app/features/cart/presentation/widgets/service_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isService = true;

  @override
  void initState() {
    context.read<CartCubit>().fetchCart();
    context.read<AddressCubit>().fetchAddress();
    context.read<ProductCartCubit>().fetchProductCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Cart"),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabTile(
                  title: "Service",
                  isSelected: isService,
                  onTap: () {
                    isService = true;
                    setState(() {});
                  }),
              SizedBox(
                width: 5.w,
              ),
              TabTile(
                  title: "Product",
                  isSelected: !isService,
                  onTap: () {
                    isService = false;
                    setState(() {});
                  })
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          isService ? const ServiceCartWidget() : const ProductCartWidget()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: isService
            ? BlocBuilder<CartCubit, CartState>(
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
                              PrimarySnackBar(context,
                                  "Your order has been placed", Colors.green);
                            }
                            if (state is PlaceOrderError) {
                              context.read<CartCubit>().fetchCart();
                              Navigator.pop(context);
                              PrimarySnackBar(
                                  context, "Something went wrong", Colors.red);
                            }
                          },
                          child: PrimaryGradientButton(
                              title: "Proceed to Payment Portal",
                              onPressed: () {
                                onServicePayment();
                              }),
                        )
                      : const SizedBox.shrink();
                },
              )
            : BlocBuilder<ProductCartCubit, ProductCartState>(
                builder: (context, state) {
                  return state is ProductCartLoaded &&
                          state.cart.items.isNotEmpty
                      ? BlocListener<PlaceOrderCubit, PlaceOrderState>(
                          listener: (context, state) {
                            if (state is PlaceOrderLoading) {
                              LoadingDialog(context);
                            }
                            if (state is PlaceOrderSuccess) {
                              Navigator.pop(context);
                              context.read<CartCubit>().fetchCart();
                              PrimarySnackBar(context,
                                  "Your order has been placed", Colors.green);
                            }
                            if (state is PlaceOrderError) {
                              context
                                  .read<ProductCartCubit>()
                                  .fetchProductCart();
                              Navigator.pop(context);
                              PrimarySnackBar(
                                  context, "Something went wrong", Colors.red);
                            }
                          },
                          child: PrimaryGradientButton(
                              title: "Proceed to Payment Portal",
                              onPressed: () {}),
                        )
                      : const SizedBox.shrink();
                },
              ),
      ),
    );
  }

  onServicePayment() async {
    DefaultDialog(context,
        title: "Cart",
        message: "What you want to do with your cart?",
        cancelText: "Alteration",
        confirmText: "Stitching", onCancel: () {
      Navigator.pop(context);

      final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
      final addressId = (context.read<AddressCubit>().state)
          .addresses!
          .elementAt(context.read<AddressCubit>().selectedAddress)
          .id;
      final cartId = (context.read<CartCubit>().state as CartLoaded).cart.id;
      final amount =
          (context.read<CartCubit>().state as CartLoaded).cart.gTotal;
      context.read<PlaceOrderCubit>().placeAlterationOrder(
          addressId: addressId!,
          cartId: cartId,
          user: user,
          amount: (amount * 100).toString());
    }, onConfirm: () {
      Navigator.pop(context);
      final user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
      final addressId = (context.read<AddressCubit>().state)
          .addresses!
          .elementAt(context.read<AddressCubit>().selectedAddress)
          .id;
      final cartId = (context.read<CartCubit>().state as CartLoaded).cart.id;
      final amount =
          (context.read<CartCubit>().state as CartLoaded).cart.gTotal;
      context.read<PlaceOrderCubit>().placeStitchingOrder(
          addressId: addressId!,
          cartId: cartId,
          user: user,
          amount: (amount * 100).toString());
    });
  }
}
