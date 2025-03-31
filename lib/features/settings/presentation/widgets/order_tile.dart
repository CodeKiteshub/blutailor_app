// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:bluetailor_app/core/theme/app_colors.dart';


class OrderTile extends StatelessWidget {
  final String orderNo;
  final String orderDate;
  final String orderPrice;
  final String orderName;
  const OrderTile({
    super.key,
    required this.orderNo,
    required this.orderDate,
    required this.orderPrice,
    required this.orderName,
  });

  @override
  Widget build(BuildContext context) {
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
                Text(orderName,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text(
                  "Order $orderNo",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Ordered on $orderDate",
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
                  "₹$orderPrice",
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
