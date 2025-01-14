import 'package:bluetailor_app/common/entities/cart_item_entity.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CartItemWidget extends StatelessWidget {
  final List<CartItemEntity> cartItem;
  const CartItemWidget({
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
          return ExpandablePanel(
              theme: const ExpandableThemeData(hasIcon: false),
              header: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(appLogo,
                        fit: BoxFit.fill, height: 120, width: 120),
                  ),
                  const Spacer(),
                  Column(
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
                      cartItem[index].alterations != null &&
                              cartItem[index].alterations!.isNotEmpty
                          ? Text(
                              "Total alterations : ${cartItem[index].alterations?.length ?? 0}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: black2),
                            )
                          : Text(
                              "Total stitching : ${cartItem[index].stitching?.styling.styles?.length ?? 0}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: black2),
                            ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "₹${cartItem[index].totalAmount}/-",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: black2),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<CartCubit>()
                              .removeItem(itemId: cartItem[index].id);
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
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: black2,
                  )
                ],
              ),
              collapsed: const SizedBox.shrink(),
              expanded: cartItem[index].alterations != null &&
                      cartItem[index].alterations!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(15),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItem[index].alterations?.length ?? 0,
                      itemBuilder: (context, indx) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem[index].alterations![indx].label +
                                  " (INR)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                  color: black2),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                                "RS. " +
                                    cartItem[index]
                                        .alterations![indx]
                                        .price
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    color: black2)),
                          ],
                        );
                      })
                  : ListView.builder(
                      padding: const EdgeInsets.all(15),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          cartItem[index].stitching?.styling.styles?.length ?? 0,
                      itemBuilder: (context, indx) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem[index]
                                  .stitching!
                                  .styling
                                  .styles?[indx]
                                  .label ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.sp,
                                  color: black2),
                            ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Text(
                            //     cartItem[index]
                            //         .stitching!
                            //         .styling
                            //         .styles[indx]
                            //         .value
                            //         .toString(),
                            //         overflow: TextOverflow.ellipsis,
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: 15.sp,
                            //         color: black2)),
                          ],
                        );
                      }));
        });
  }
}
