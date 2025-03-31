import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/store_order/store_order_cubit.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class StoreOrderWidget extends StatelessWidget {
  const StoreOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<StoreOrderCubit, StoreOrderState>(
          builder: (context, state) {
        if (state is StoreOrderLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
            itemCount: state.storeOrders.length,
            itemBuilder: (context, index) {
              final date = DateFormat('dd-MM-yyyy').format(DateTime(
                  state.storeOrders[index].orderDate?.year ?? 2024,
                  state.storeOrders[index].orderDate?.month ?? 1,
                  state.storeOrders[index].orderDate?.day ?? 1));

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order-detail', arguments: {
                    "orderPrice": state.storeOrders[index].orderTotal,
                    "orderDate": date,
                    "orderStatus": state.storeOrders[index].orderStatus,
                    "orderSrNo": state.storeOrders[index].orderNo
                  });
                },
                child: OrderTile(
                  orderDate: date,
                  orderNo: state.storeOrders[index].orderNo.toString(),
                  orderName: state.storeOrders[index].orderItems.firstOrNull
                          ?.itemName ??
                      "",
                  orderPrice: state.storeOrders[index].orderTotal.toString(),
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
