import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MediaHistory extends StatefulWidget {
  const MediaHistory({super.key});

  @override
  State<MediaHistory> createState() => _MediaHistoryState();
}

class _MediaHistoryState extends State<MediaHistory> {
  int selectedIndex = 0;

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
                    "Media History",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.folder,
                    color: Colors.white,
                    size: 24.sp,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
             
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TabTile(
                          title: "Photo",
                          isSelected: selectedIndex == 0,
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                        ),
                        TabTile(
                          title: "Video",
                          isSelected: selectedIndex == 1,
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                        TabTile(
                          title: "PDF",
                          isSelected: selectedIndex == 2,
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
