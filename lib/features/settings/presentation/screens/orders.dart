import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
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
    context.read<SettingsBloc>().add(FetchOrderHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Orders"),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        if (state is OrderHistoryLoaded) {
          return ListView.builder(
            itemCount: state.orderHistory.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order-detail');
                },
                child: OrderTile(
                    orderId: state.orderHistory[index].orderSrNo.toString(),
                    price: state.orderHistory[index].orderTotal.toString(),
                    name: state.orderHistory[index].items[0].name,
                    day: 8,
                    month: 78,
                    year: 43),
              );
            },
          );
        } else {
          return LoadingAnimationWidget.beat(color: primaryBlue, size: 50);
        }
      }),
    );
  }
}
