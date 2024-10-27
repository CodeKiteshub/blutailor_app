// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/pick_img_bottomsheet.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/alteration/presentation/widgets/alteration_image_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UploadImage extends StatefulWidget {
  final SelectedCatModel selectedCat;
  const UploadImage({super.key, required this.selectedCat});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String img = "";
  String video = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(),
          Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.h),
            child: Text(
              "Alteration",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
              child: Container(
            color: Colors.white,
            width: double.infinity,
            padding:
                EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
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
                AlterationImageBox(
                    img: img,
                    dummyImg: widget.selectedCat.img!,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => ImgPickBottomSheet(
                                camTapped: () async {
                                  final pickedFile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (pickedFile != null) {
                                    final croppedFile =
                                        await cropImg(pickedFile);
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
                                    final croppedFile =
                                        await cropImg(pickedFile);
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
                AlterationImageBox(
                    img: video,
                    dummyImg: widget.selectedCat.img!,
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
          ))
        ],
      )),
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
              });
            }),
      ),
    );
  }
}
