// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/common/widgets/pick_img_bottomsheet.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/selected_alteration_cat_entity.dart';
import 'package:bluetailor_app/common/widgets/image_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UploadImage extends StatefulWidget {
  final Function onTap;
  final SelectedAlterationCatEntity selectedCat;
  const UploadImage(
      {super.key, required this.selectedCat, required this.onTap});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String img = "";
  String video = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Alteration"),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.selectedCat.label} Alteration",
                style: TextStyle(
                    color: const Color(0xFF383A3A),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp)),
            SizedBox(
              height: 2.h,
            ),
            Text("Upload Garment Images and Videos Below",
                style: TextStyle(
                    color: const Color(0xFF383A3A),
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp)),
            SizedBox(
              height: 3.h,
            ),
            ImgBox(
                selectedImg: img,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => ImgPickBottomSheet(
                            camTapped: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (pickedFile != null) {
                                final croppedFile = await cropImg(pickedFile);
                                if (croppedFile != null) {
                                  setState(() {
                                    img = croppedFile.path;
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                            galleryTapped: () async {
                              final pickedFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                final croppedFile = await cropImg(pickedFile);
                                if (croppedFile != null) {
                                  setState(() {
                                    img = croppedFile.path;
                                  });
                                }
                              }
                              Navigator.pop(context);
                            },
                          ));
                },
                title: "Upload Garment Image"),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 2,
                  color: const Color(0xFF3B3B3A).withValues(alpha: 0.75),
                )),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "OR",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                    child: Container(
                  height: 2,
                  color: const Color(0xFF3B3B3A).withValues(alpha: 0.75),
                )),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            ImgBox(
                selectedImg: video,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => ImgPickBottomSheet(
                            camTapped: () async {
                              final pickedFile = await ImagePicker()
                                  .pickVideo(source: ImageSource.camera);
                              if (pickedFile != null) {
                                setState(() {
                                  video = pickedFile.path;
                                });
                              }
                              Navigator.pop(context);
                            },
                            galleryTapped: () async {
                              final pickedFile = await ImagePicker()
                                  .pickVideo(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  video = pickedFile.path;
                                });
                              }
                              Navigator.pop(context);
                            },
                          ));
                },
                title: "Upload Garment Video"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(
            title: "Proceed",
            onPressed: () {
              Navigator.pushNamed(context, '/alteration-details', arguments: {
                "selectedCat": widget.selectedCat,
                "imgFile": img,
                "videoFile": video,
                "onTap": widget.onTap
              });
            }),
      ),
    );
  }
}
