import 'package:bluetailor_app/common/cubit/user_cubit/app_user_cubit.dart';
import 'package:bluetailor_app/common/models/address_model.dart';
import 'package:bluetailor_app/common/widgets/address_box_widget.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:bluetailor_app/features/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:bluetailor_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class CreateAppointment extends StatefulWidget {
  final bool? isBack;
  const CreateAppointment({super.key, this.isBack = false});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  TextEditingController purposeController = TextEditingController();
  String selectedCat = "Studio Visit";
  String dateString = "Tap on Icon to select date and time";

  DateTime? selectedDate;

  @override
  void initState() {
    context.read<AddressCubit>().fetchAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  appointmentTop,
                  fit: BoxFit.fitWidth,
                  width: 100.w,
                ),
                Positioned(
                  top: 5.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: widget.isBack == true
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      if (widget.isBack == true) ...[
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(backIcon)),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                      Text(
                        "Book an Appointment",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appointment Type",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.sp,
                        color: black2),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TabTile(
                          title: "Studio Visit",
                          isSelected: selectedCat == "Studio Visit",
                          onTap: () {
                            selectedCat = "Studio Visit";
                            setState(() {});
                          }),
                      TabTile(
                          title: "Video Call",
                          isSelected: selectedCat == "Video Call",
                          onTap: () {
                            selectedCat = "Video Call";
                            setState(() {});
                          }),
                      TabTile(
                          title: "Door Visit",
                          isSelected: selectedCat == "Door Visit",
                          onTap: () {
                            selectedCat = "Door Visit";
                            setState(() {});
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "Choose a date and time",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: black2),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? dateTime = await showOmniDateTimePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        lastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: false,
                        isShowSeconds: false,
                        minutesInterval: 1,
                        secondsInterval: 1,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 650,
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(
                            opacity: anim1.drive(
                              Tween(
                                begin: 0,
                                end: 1,
                              ),
                            ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                        selectableDayPredicate: (dateTime) {
                          if (dateTime.millisecondsSinceEpoch >=
                              (DateTime.now().millisecondsSinceEpoch -
                                  100000000)) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                      );
                      setState(() {
                        dateString =
                            DateFormat('E, d MMM yyy HH:mm').format(dateTime!);

                        selectedDate = dateTime;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffc7c7c7)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: const BoxDecoration(
                                  color: primaryBlue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            dateString,
                            style: TextStyle(
                                fontFamily: "dmsans",
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 14.sp),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (selectedCat == "Door Visit") ...[
                    SizedBox(
                      height: 4.h,
                    ),
                    BlocBuilder<AddressCubit, AddressState>(
                      builder: (context, state) {
                        if (state.addressStatus == AddressStatus.loaded &&
                            state.addresses!.isNotEmpty) {
                          return AddressBoxWidget(
                            address: state.addresses!.elementAt(
                                context.read<AddressCubit>().selectedAddress),
                            changeAddress: true,
                          );
                        } else {
                          return const EmptyAddressBox();
                        }
                      },
                    ),
                  ],
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: black2),
                  ),
                  Text(
                    "Explain your requirement below",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: const Color(0xff8c8c8c)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  PrimaryTextField(
                    title: "",
                    maxLines: 3,
                    border: true,
                    controller: purposeController,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  BlocListener<AppointmentCubit, AppointmentState>(
                    listener: (context, state) {
                      if (state is AppointmentLoading) {
                        LoadingDialog(context);
                      }
                      if (state is AppointmentError) {
                        Navigator.pop(context);
                        PrimarySnackBar(context, state.error, Colors.red);
                      }
                      if (state is AppointmentSaved) {
                        Navigator.pop(context);
                        purposeController.clear();
                        PrimarySnackBar(context, "Your Appointment is created.",
                            Colors.green);
                      }
                    },
                    child: PrimaryGradientButton(
                      title: "Submit",
                      onPressed: () {
                        if (sl<SharedPreferences>().getString("userId") ==
                            null) {
                          DefaultDialog(context,
                              title: "Alert!",
                              message:
                                  "To use this feature, you will need to login as it is tied to your user specific profile",
                              cancelText: "Cancel",
                              confirmText: "Login/Signup", onCancel: () {
                            Navigator.pop(context);
                          }, onConfirm: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/auth-selection", (route) => false);
                          });
                        } else {
                          if (selectedDate != null) {
                            final user = (context.read<AppUserCubit>().state
                                    as AppUserLoggedIn)
                                .user;

                            final address = (context.read<AddressCubit>().state)
                                .addresses!
                                .elementAt(context
                                    .read<AddressCubit>()
                                    .selectedAddress);
                            context.read<AppointmentCubit>().saveAppointment(
                                user: user,
                                lookingFor: purposeController.text,
                                type: selectedCat,
                                selectedDate: selectedDate!,
                                address: selectedCat == "Door Visit"
                                    ? (address as AddressModel)
                                        .toMap(userId: user.id)
                                    : null);
                          } else {
                            PrimarySnackBar(
                                context, "Please Select Date", Colors.red);
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
