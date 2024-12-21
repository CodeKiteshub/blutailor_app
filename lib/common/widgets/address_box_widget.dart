import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/address/domain/entities/address_entity.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AddressBoxWidget extends StatelessWidget {
  final AddressEntity address;
  final bool changeAddress;
  const AddressBoxWidget(
      {super.key, required this.address, this.changeAddress = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: 100.w,
          decoration: BoxDecoration(
              color: const Color(0xfff4f4f4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xffcecece), width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               address.name == "" ? "Address" : address.name,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: black2),
              ),
              SizedBox(height: 1.h),
              Text(
                address.address,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: black2),
              ),
              SizedBox(height: 1.h),
              Text(
                address.city + " " + address.state + " " + address.country,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: black2),
              ),
              SizedBox(height: 1.h),
              Text(
                address.pincode + " " + address.phone,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: black2),
              ),
              SizedBox(
                height: 2.h,
              ),
              changeAddress == true
                  ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/address",
                            arguments: true);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0XFFD4D4D4), width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4))
                            ]),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Change",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: black2),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/add-address",
                                arguments: address);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0XFFD4D4D4), width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
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
                                .deleteAddress(id: address.id!);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                                color: primaryRed,
                                border: Border.all(
                                    color: const Color(0XFFD4D4D4), width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
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
  }
}
