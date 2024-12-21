import 'package:bluetailor_app/common/widgets/address_box_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class AddressList extends StatefulWidget {
  final bool choose;
  const AddressList({super.key, this.choose = false});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  bool isPickup = true;
  int selected = 0;

  @override
  void initState() {
    context.read<AddressCubit>().fetchAddress();
    if (widget.choose) {
      selected = context.read<AddressCubit>().selectedAddress;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Address"),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     TabTile(
          //         title: "Pickup",
          //         isSelected: isPickup == true,
          //         onTap: () {
          //           isPickup = true;
          //           setState(() {});
          //         }),
          //     SizedBox(
          //       width: 10.w,
          //     ),
          //     TabTile(
          //         title: "Delivery",
          //         isSelected: isPickup == false,
          //         onTap: () {
          //           isPickup = false;
          //           setState(() {});
          //         }),
          //   ],
          // ),
          // SizedBox(
          //   height: 2.h,
          // ),
          BlocConsumer<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state.addressStatus == AddressStatus.deleted) {
                PrimarySnackBar(context, 'Address is deleted', Colors.green);
                context.read<AddressCubit>().fetchAddress();
              }
            },
            builder: (context, state) {
              if (state.addressStatus == AddressStatus.loaded) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                    itemCount: state.addresses?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          if (widget.choose) ...[
                          Radio(
                              value: index,
                              groupValue: selected,
                              onChanged: (value) {
                                selected = value as int;
                                setState(() {});
                              }),
                          SizedBox(
                            width: 3.w,
                          ),
                          ],
                          Expanded(
                              child: AddressBoxWidget(
                            address: state.addresses![index],
                          )),
                        ],
                      );
                    });
              } else {
                return Center(
                  child:
                      LoadingAnimationWidget.beat(color: primaryBlue, size: 50),
                );
              }
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(
            title: widget.choose ? "Choose Address" : "Add New Address",
            onPressed: () {
              if (widget.choose) {
                context.read<AddressCubit>().changeAddress(selected);
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, "/add-address");
              }
            }),
      ),
    );
  }
}
