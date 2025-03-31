import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/product_order/product_order_cubit.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/settings/settings_bloc.dart';
import 'package:bluetailor_app/features/settings/presentation/bloc/store_order/store_order_cubit.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/product_order_widget.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/service_order_widget.dart';
import 'package:bluetailor_app/features/settings/presentation/widgets/store_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int isSelected = 0;
  String selectedTab = "Service";

  @override
  void initState() {
    context.read<SettingsBloc>().add(FetchOrderHistoryEvent());
    context.read<StoreOrderCubit>().fetchStoreOrder();
    context.read<ProductOrderCubit>().fetchProductOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Orders"),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabTile(
                  title: "Service",
                  isSelected: selectedTab == "Service",
                  onTap: () {
                    selectedTab = "Service";
                    setState(() {});
                  }),
              SizedBox(
                width: 5.w,
              ),
              TabTile(
                  title: "App",
                  isSelected: selectedTab == "App",
                  onTap: () {
                    selectedTab = "App";
                    setState(() {});
                  }),
              SizedBox(
                width: 5.w,
              ),
              TabTile(
                  title: "Store",
                  isSelected: selectedTab == "Store",
                  onTap: () {
                    selectedTab = "Store";
                    setState(() {});
                  })
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          switchTab(selectedTab)
        ],
      ),
    );
  }

  Widget switchTab(String tabTitle) {
    switch (tabTitle) {
      case "Service":
        return const ServiceOrderWidget();

      case "App":
        return const ProductOrderWidget();

      case "Store":
        return const StoreOrderWidget();

      default:
        return const SizedBox.shrink();
    }
  }
}
