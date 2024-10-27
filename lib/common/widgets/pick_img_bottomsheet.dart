import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImgPickBottomSheet extends StatelessWidget {
  final VoidCallback camTapped;
  final VoidCallback galleryTapped;
  const ImgPickBottomSheet(
      {super.key, required this.camTapped, required this.galleryTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      width: 100.w,
      color: primaryBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: camTapped,
              child: const Icon(
                CupertinoIcons.camera,
                color: Colors.white,
              )),
          InkWell(
            onTap: galleryTapped,
            child: const Icon(
              CupertinoIcons.photo,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
