import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/chat/presentation/widgets/message_input_widget.dart';
import 'package:bluetailor_app/features/chat/presentation/widgets/reciever_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            const AppBarWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chat",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/media-history');
                    },
                    child: Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                      left: 3.w, right: 3.w, top: 3.h, bottom: 3.h),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(chatBG),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1.h,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return const RecieverWidget();
                    },
                  )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MessageInputWidget(),
    );
  }
}
