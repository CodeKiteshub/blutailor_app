import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class OrderDetail extends StatelessWidget {
  final OrderEntity order;
  const OrderDetail({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd-MM-yyyy').format(DateTime(
        order.orderDateTime.year,
        order.orderDateTime.month,
        order.orderDateTime.day));
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(),
          Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.h),
            child: Text(
              "Orders",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: 100.w,
              child: Column(
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
                          "Order ID: ${order.orderSrNo}",
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
                                  text: order.status,
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
                          "Ordered on $date",
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
                          "₹${order.orderTotal}",
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
            ),
          ),
        ],
      )),
    );
  }
}
