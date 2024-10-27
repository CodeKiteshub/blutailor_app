

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderTile extends StatelessWidget {
  final String name;
  final String orderId;
  final int day;
  final int month;
  final int year;
  final String price;
  const OrderTile({
    super.key,
    required this.orderId,
    required this.price,
    required this.day,
    required this.month,
    required this.year, required this.name,
  });

  @override
  Widget build(BuildContext context) {
   // final date = DateFormat('d MMM yyy').format(DateTime(year, month, day));
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
                Text(name,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text(
                  "Order $orderId",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Ordered on ",
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
                  "₹$price",
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
