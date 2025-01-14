// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/domain/entities/order_entity.dart';

class OrderTile extends StatelessWidget {
  final OrderEntity order;
  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd-MM-yyyy').format(DateTime(
        order.orderDateTime.year,
        order.orderDateTime.month,
        order.orderDateTime.day));
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: primaryBlue),
      padding: EdgeInsets.only(left: 7.w, top: 2.h, bottom: 2.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.items.firstOrNull?.name ?? "",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text(
                  "Order ${order.orderSrNo}",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Ordered on $date",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9A9A9A)),
                ),
                // SizedBox(height: 1.h),
                // Text(
                //   "Stylist - Priya Jaiswal",
                //   style: TextStyle(
                //       fontSize: 11.sp,
                //       fontFamily: "dmsans",
                //       fontWeight: FontWeight.w500,
                //       color: const Color(0xFF9A9A9A)),
                // ),
                SizedBox(height: 1.h),
                Text(
                  "₹${order.orderTotal}",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontFamily: "dmsans",
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
          ),
          const Expanded(
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }
}
