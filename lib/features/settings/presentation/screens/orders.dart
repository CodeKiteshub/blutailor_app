import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int isSelected = 0;

  @override
  void initState() {
    context.read<SettingsBloc>().add(FetchProductOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabTile(
                        title: "App",
                        isSelected: isSelected == 0,
                        onTap: () {
                          context
                              .read<SettingsBloc>()
                              .add(FetchProductOrderEvent());
                          setState(() {
                            isSelected = 0;
                          });
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      TabTile(
                        title: "Store",
                        isSelected: isSelected == 1,
                        onTap: () {
                          context
                              .read<SettingsBloc>()
                              .add(FetchStoreOrderEvent());
                          setState(() {
                            isSelected = 1;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: isSelected == 0
                        ? BlocBuilder<SettingsBloc, SettingsState>(
                            builder: (context, state) {
                            if (state is ProductOrderLoaded) {
                              return ListView.builder(
                                itemCount: state.productOrders.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/order-detail');
                                    },
                                    child: OrderTile(
                                        orderId: state
                                            .productOrders[index].orderId
                                            .toString(),
                                        price: state
                                            .productOrders[index].orderTotal
                                            .toString(),
                                        name: state.productOrders[index]
                                            .orderItems[0].name,
                                        day: 8,
                                        month: 78,
                                        year: 43),
                                  );
                                },
                              );
                            } else {
                              return LoadingAnimationWidget.beat(
                                  color: primaryBlue, size: 50);
                            }
                          })
                        : BlocBuilder<SettingsBloc, SettingsState>(
                            builder: (context, state) {
                              if (state is StoreOrderLoaded) {
                                return ListView.builder(
                                  itemCount: state.storeOrders.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/order-detail');
                                      },
                                      child: OrderTile(
                                          orderId: state
                                              .storeOrders[index].orderNo
                                              .toString(),
                                          price: state
                                              .storeOrders[index].orderTotal
                                              .toString(),
                                          name: state.storeOrders[index]
                                              .orderItems[0].itemName,
                                          day: 8,
                                          month: 78,
                                          year: 43),
                                    );
                                  },
                                );
                              } else {
                                return LoadingAnimationWidget.beat(
                                    color: primaryBlue, size: 50);
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
