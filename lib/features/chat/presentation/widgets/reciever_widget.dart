import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/chat/presentation/widgets/message_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecieverWidget extends StatelessWidget {
  const RecieverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 2.5.h,
        ),
        SizedBox(
          width: 2.w,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            constraints: BoxConstraints(
              minWidth: 20.w,
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            decoration: BoxDecoration(
                color: primaryBlue, borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lifestyle Expert",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 1.h,
                ),
                const MessageBoxWidget(
                  message:
                      "Hello, I plan to attend a wedding in a few days and would like some advice on what formal clothing would suit me. could you please help me out?",
                ),
              ],
            )),
      ],
    );
  }
}