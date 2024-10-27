import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/chat/presentation/widgets/message_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SenderWidget extends StatelessWidget {
  const SenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            constraints: BoxConstraints(
              minWidth: 20.w,
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            decoration: BoxDecoration(
                color: primaryBlue, borderRadius: BorderRadius.circular(6)),
            child: Column(
              children: [
                const MessageBoxWidget(
                  message:
                      "Hello, I plan to attend a wedding in a few days and would like some advice on what formal clothing would suit me. could you please help me out?",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "12:00 PM",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14.sp,
                    )
                  ],
                )
              ],
            )),
        SizedBox(
          width: 2.w,
        ),
        CircleAvatar(
          radius: 2.5.h,
        ),
      ],
    );
  }
}
