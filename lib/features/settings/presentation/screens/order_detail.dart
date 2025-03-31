
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderDetail extends StatelessWidget {
  final String orderDate;
  final dynamic orderSrNo;
  final String orderStatus;
  final int orderPrice;
  const OrderDetail(
      {super.key,
      required this.orderDate,
      required this.orderSrNo,
      required this.orderStatus,
      required this.orderPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Orders"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Details",
                    style: TextStyle(
                        color: const Color(0xFF3B3A3A),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Order ID: $orderSrNo",
                  style: TextStyle(
                      color: const Color(0xFF3B3A3A),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text.rich(TextSpan(
                    text: "Order Status: ",
                    style: TextStyle(
                        color: const Color(0xFF9A9A9A),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: orderStatus,
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700))
                    ])),
                SizedBox(
                  height: 2.h,
                ),
                // Text(
                //   "Stylist - Priya Jaiswal",
                //   style: TextStyle(
                //       color: const Color(0xFF9A9A9A),
                //       fontSize: 16.sp,
                //       fontWeight: FontWeight.w500),
                // ),
                // SizedBox(
                //   height: 1.h,
                // ),
                Text(
                  "Ordered on $orderDate",
                  style: TextStyle(
                      color: const Color(0xFF9A9A9A),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 1.h,
                ),
                // Text(
                //   "Studio ID HY01",
                //   style: TextStyle(
                //       color: const Color(0xFF9A9A9A),
                //       fontSize: 16.sp,
                //       fontWeight: FontWeight.w500),
                // ),
                // SizedBox(
                //   height: 2.h,
                // ),
                Text(
                  "₹$orderPrice",
                  style: TextStyle(
                      color: const Color(0xFF3B3A3A),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFE5E5E5),
            thickness: 10,
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Alterations Done",
          //           style: TextStyle(
          //               color: const Color(0xFF3B3A3A),
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w600)),
          //       SizedBox(
          //         height: 2.h,
          //       ),
          //       Text(
          //         "Shirt sleeve length",
          //         style: TextStyle(
          //             color: const Color(0xFF898989),
          //             fontSize: 16.sp,
          //             fontWeight: FontWeight.w500),
          //       ),
          //       SizedBox(
          //         height: 1.h,
          //       ),
          //       Text(
          //         "-0.5 inches",
          //         style: TextStyle(
          //             color: const Color(0xFF3B3A3A),
          //             fontSize: 15.sp,
          //             fontWeight: FontWeight.w500),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
