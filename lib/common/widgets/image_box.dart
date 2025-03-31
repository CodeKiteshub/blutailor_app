import 'dart:io';

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class ImgBox extends StatelessWidget {
  final String selectedImg;
  final String? savedImg;
  final String title;
  final VoidCallback onTap;
  const ImgBox(
      {super.key,
      required this.selectedImg,
      required this.onTap,
      required this.title,
      this.savedImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffcccccc)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 15.h,
              alignment: Alignment.center,
              child: selectedImg != ""
                  ? Image.file(File(selectedImg))
                  : savedImg != null && savedImg != ""
                      ? CachedNetworkImage(imageUrl: savedImg!)
                      : SvgPicture.asset(
                          hanger,
                          height: 5.h,
                        )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: const BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                          gradient: borderGradient,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Upload",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Icon(
                            Icons.upload,
                            color: Colors.white,
                            size: 15.sp,
                          )
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
