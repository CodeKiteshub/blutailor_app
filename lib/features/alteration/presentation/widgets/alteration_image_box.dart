import 'dart:io';

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlterationImageBox extends StatelessWidget {
  final String img;
  final String dummyImg;
  final String? savedImg;
  final String title;
  final VoidCallback onTap;
  const AlterationImageBox(
      {super.key,
      required this.img,
      required this.dummyImg,
      required this.onTap,
      required this.title,
      this.savedImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: primaryBlue,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4)
          ],
          border: Border.all(color: const Color(0xff6a6a6a)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(imgBack, 
              width: 40.w,
              fit: BoxFit.fitWidth,),
              img != ""
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: Image.file(
                        File(img),
                        height: 20.h,
                        width: 40.w,
                      ),
                    )
                  : savedImg != null && savedImg != ""
                      ? Image.network(
                          savedImg!,
                          height: 20.h,
                          width: 40.w,
                        )
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                          child: CachedNetworkImage(
                            imageUrl: dummyImg,
                            height: 20.h,
                            width: 40.w,
                      
                          ),
                        ),
            ],
          ),
          SizedBox(
            width: 6.w,
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
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
          ))
        ],
      ),
    );
  }
}
