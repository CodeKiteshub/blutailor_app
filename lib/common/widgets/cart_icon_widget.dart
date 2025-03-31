import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/product_cart_cubit/product_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({
    super.key,
  });

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  @override
  void initState() {
    context.read<CartCubit>().fetchCart();
    context.read<ProductCartCubit>().fetchProductCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/cart-screen');
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, serviceCart) {
          return BlocBuilder<ProductCartCubit, ProductCartState>(
            builder: (context, productCart) {
              // Get the length of items in both carts
              int cart1Length = 0;
              int cart2Length = 0;

              if (serviceCart is CartLoaded) {
                cart1Length = serviceCart.cart.items.length;
              }
              if (productCart is ProductCartLoaded) {
                cart2Length = productCart.cart.items.length;
              }

              int totalItems = cart1Length + cart2Length;
              return badges.Badge(
                position: badges.BadgePosition.bottomEnd(bottom: -7, end: 0),
                badgeStyle: const badges.BadgeStyle(badgeColor: primaryRed),
                badgeContent: Text(
                  totalItems.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 23.sp,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
