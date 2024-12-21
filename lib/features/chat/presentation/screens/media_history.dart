
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/tab_tile.dart';
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
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Media History"),
      body: Container(
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
    );
  }
}
