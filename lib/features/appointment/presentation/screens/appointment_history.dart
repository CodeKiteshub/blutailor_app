
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  int isSelected = 0;

  @override
  void initState() {
    context.read<AppointmentCubit>().fetchAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Appointments"),
      body: Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 3.h,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabTile(
                    title: "Studio Visit",
                    isSelected: isSelected == 0,
                    onTap: () {
                      isSelected = 0;
                      setState(() {});
                    }),
                TabTile(
                    title: "Video Call",
                    isSelected: isSelected == 1,
                    onTap: () {
                      isSelected = 1;
                      setState(() {});
                    }),
                TabTile(
                    title: "Door Visit",
                    isSelected: isSelected == 2,
                    onTap: () {
                      isSelected = 2;
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            BlocBuilder<AppointmentCubit, AppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoaded) {
                  final studioList = state.appointments
                      .where((e) =>
                          e.appointmentType.toLowerCase() == "studio visit")
                      .toList();
                  final videoList = state.appointments
                      .where((e) =>
                          e.appointmentType.toLowerCase() == "video call")
                      .toList();
                  final doorList = state.appointments
                      .where((e) =>
                          e.appointmentType.toLowerCase() == "door visit")
                      .toList();
                  if (isSelected == 0) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/appointment-details",
                                    arguments: studioList[index]);
                              },
                              child: AppointmentTile(
                                id: studioList[index].appointmentId.toString(),
                                title: studioList[index].lookingFor.first,
                                bookingDate:
                                    studioList[index].dateRecorded.timestamp ??
                                        "",
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                        itemCount: studioList.length);
                  }
                  if (isSelected == 1) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/appointment-details",
                                    arguments: videoList[index]);
                              },
                              child: AppointmentTile(
                                id: videoList[index].appointmentId.toString(),
                                title: videoList[index].lookingFor.first,
                                bookingDate:
                                    videoList[index].dateRecorded.timestamp ??
                                        "",
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                        itemCount: videoList.length);
                  }
                  if (isSelected == 2) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, "/appointment-details",
                                    arguments: doorList[index]);
                              },
                              child: AppointmentTile(
                                id: doorList[index].appointmentId.toString(),
                                title: doorList[index].lookingFor.first,
                                bookingDate:
                                    doorList[index].dateRecorded.timestamp ??
                                        "",
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                        itemCount: doorList.length);
                  }
                  return const SizedBox.shrink();
                } else {
                  return Center(
                      child: LoadingAnimationWidget.beat(
                          color: primaryBlue, size: 50));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentTile extends StatelessWidget {
  final String title;
  final String id;
  final String bookingDate;
  const AppointmentTile({
    super.key,
    required this.title,
    required this.id,
    required this.bookingDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: primaryBlue, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Appointment $id",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Booked on $bookingDate",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xff9a9a9a)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.arrow_forward_ios,
                color: primaryBlue,
                size: 16.sp,
              ))
        ],
      ),
    );
  }
}
