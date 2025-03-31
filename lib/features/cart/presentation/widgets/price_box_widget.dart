
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PriceBoxWidget extends StatelessWidget {
  final dynamic total;
  final dynamic gTotal;
  final dynamic discTotal;
  const PriceBoxWidget({
    super.key, required this.gTotal,
    required this.total,
    required this.discTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          border: Border.all(color: const Color(0xFFE3E3E3)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Total",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: black2),
              ),
              Text(
                "Rs.$total/-",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: black2),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discount (10%)",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: black2),
              ),
              Text(
                "Rs.${discTotal.round()}/-",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: black2),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Net Price",
          //       style: TextStyle(
          //           fontWeight: FontWeight.w400,
          //           fontSize: 16.sp,
          //           color: black2),
          //     ),
          //     Text(
          //       "Rs.500/-",
          //       style: TextStyle(
          //           fontWeight: FontWeight.w400,
          //           fontSize: 15.sp,
          //           color: black2),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 1.h,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "GST (12)",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: black2),
              ),
              Text(
                "Rs.0/-",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: black2),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          const Divider(),
          SizedBox(
            height: 2.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Final Price",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: black2),
              ),
              Text(
                "Rs.${gTotal.round()}/-",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: black2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
