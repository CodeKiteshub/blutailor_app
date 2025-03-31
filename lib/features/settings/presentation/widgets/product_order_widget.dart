import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/product_order/product_order_cubit.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ProductOrderWidget extends StatelessWidget {
  const ProductOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductOrderCubit, ProductOrderState>(
          builder: (context, state) {
        if (state is ProductOrderLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
            itemCount: state.productOrders.length,
            itemBuilder: (context, index) {
              final date = DateFormat('dd-MM-yyyy').format(DateTime(
                  state.productOrders[index].orderDate.year,
                  state.productOrders[index].orderDate.month,
                  state.productOrders[index].orderDate.day));

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order-detail', arguments: {
                    "orderPrice": state.productOrders[index].orderTotal,
                    "orderDate": date,
                    "orderStatus": state.productOrders[index].orderStatus,
                    "orderSrNo": state.productOrders[index].orderId
                  });
                },
                child: OrderTile(
                  orderDate: date,
                  orderNo: state.productOrders[index].orderId.toString(),
                  orderName:
                      state.productOrders[index].orderItems.firstOrNull?.name ??
                          "",
                  orderPrice: state.productOrders[index].orderTotal.toString(),
                ),
              );
            },
          );
        } else {
          return Center(
              child: LoadingAnimationWidget.beat(color: primaryBlue, size: 50));
        }
      }),
    );
  }
}
