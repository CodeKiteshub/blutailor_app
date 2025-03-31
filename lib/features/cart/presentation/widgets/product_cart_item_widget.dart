import 'package:bluetailor_app/common/entities/product_cart_entity.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/product_cart_cubit/product_cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProductCartItemWidget extends StatelessWidget {
  final List<ProductCartItemEntity> cartItem;
  const ProductCartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              height: 2.h,
            ),
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartItem.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                    imageUrl: cartItem[index].images.first,
                    fit: BoxFit.fill,
                    height: 120,
                    width: 120),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: black2),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "₹${cartItem[index].price}/-",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: black2),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<ProductCartCubit>()
                            .removeItemFromCart(itemId: cartItem[index].itemId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: primaryRed,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Delete",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 15.sp,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
