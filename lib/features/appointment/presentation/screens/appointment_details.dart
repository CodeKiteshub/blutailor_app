import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppointmentDetails extends StatelessWidget {
  final AppointmentEntity appointment;
  const AppointmentDetails({super.key, required this.appointment});

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
              "Appointments",
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
            width: 100.w,
            padding:
                EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointment Details',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Appointment Id ${appointment.appointmentId}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text.rich(TextSpan(
                    text: "Appointment status - ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Color(0xff898989)),
                    children: [
                      TextSpan(
                          text: "Upcoming",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.green))
                    ])),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Stylist',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: const Color(0xff898989)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  appointment.stylist.firstOrNull?.name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Appointment Type',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: const Color(0xff898989)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  appointment.appointmentType,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Date and Time of Appointment',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: const Color(0xff898989)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  appointment.appointmentDate.timestamp ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Booked On',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: const Color(0xff898989)),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  appointment.dateRecorded.timestamp ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: black2),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
