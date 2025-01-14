import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
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
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            padding:
                EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 5.h),
            itemCount: state.orderHistory.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/order-detail',
                      arguments: state.orderHistory[index]);
                },
                child: OrderTile(
                  order: state.orderHistory[index],
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
