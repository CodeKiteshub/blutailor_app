import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_strings.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  bool isPickup = true;

  @override
  void initState() {
    context.read<AddressCubit>().fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        toolbarHeight: 8.h,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: SvgPicture.asset(backIcon),
          ),
        ),
        title: Text(
          "Address",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: Colors.white),
        ),
      ),
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
                      return Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: const Color(0xfff4f4f4),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0xffcecece),
                                    width: 0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address ${index + 1}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.sp,
                                      color: black2),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  state.addresses![index].address,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: black2),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  state.addresses![index].city +
                                      " " +
                                      state.addresses![index].state +
                                      " " +
                                      state.addresses![index].country,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: black2),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  state.addresses![index].pincode +
                                      " " +
                                      state.addresses![index].phone,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: black2),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/add-address",
                                            arguments: state.addresses![index]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color(0XFFD4D4D4),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 4))
                                            ]),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: black2),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Icon(
                                              Icons.edit,
                                              size: 12.sp,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<AddressCubit>()
                                            .deleteAddress(
                                                id: state
                                                    .addresses![index].id!);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                            color: primaryRed,
                                            border: Border.all(
                                                color: const Color(0XFFD4D4D4),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.25),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 4))
                                            ]),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Icon(
                                              Icons.delete,
                                              size: 12.sp,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                "assets/images/truck.png",
                                height: 8.h,
                              ))
                        ],
                      );
                    });
              } else {
                return Center(
                  child: LoadingAnimationWidget.beat(
                      color: primaryBlue, size: 50),
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
            title: "Add New Address",
            onPressed: () {
              Navigator.pushNamed(context, "/add-address");
            }),
      ),
    );
  }
}
