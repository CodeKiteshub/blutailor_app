import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ServiceOrderWidget extends StatelessWidget {
  const ServiceOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        if (state is OrderHistoryLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
            itemCount: state.orderHistory.length,
            itemBuilder: (context, index) {
              final date = DateFormat('dd-MM-yyyy').format(DateTime(
                  state.orderHistory[index].orderDateTime.year,
                  state.orderHistory[index].orderDateTime.month,
                  state.orderHistory[index].orderDateTime.day));
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order-detail', arguments: {
                    "orderPrice": state.orderHistory[index].orderTotal,
                    "orderDate": date,
                    "orderStatus": state.orderHistory[index].status,
                    "orderSrNo": state.orderHistory[index].orderSrNo
                  });
                },
                child: OrderTile(
                  orderDate: date,
                  orderNo: state.orderHistory[index].orderSrNo.toString(),
                  orderName:
                      state.orderHistory[index].items.firstOrNull?.name ?? "",
                  orderPrice: state.orderHistory[index].orderTotal.toString(),
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
