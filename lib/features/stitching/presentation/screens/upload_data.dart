// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/common/widgets/pick_img_bottomsheet.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/img/functions_and_aws.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_stitching_cat_entity.dart';
import 'package:bluetailor_app/features/stitching/presentation/widgets/stitching_image_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UploadData extends StatefulWidget {
  final SelectedStitchingCatEntity selectedCat;
  const UploadData({super.key, required this.selectedCat});

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  String img = "";
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    lengthController.dispose();
    widthController.dispose();
    nameController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Stitching"),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload your fabric images and it's measurement details ",
                  style: TextStyle(
                      color: primaryBlack,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Garment Name",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: black2),
              ),
              SizedBox(
                height: 1.h,
              ),
              PrimaryTextField(
                title: "Name",
                border: true,
                controller: nameController,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Fabric Length (Inches)",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: black2),
              ),
              SizedBox(
                height: 1.h,
              ),
              PrimaryTextField(
                title: "Length",
                border: true,
                controller: lengthController,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Fabric Width (Inches)",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                    color: black2),
              ),
              SizedBox(
                height: 1.h,
              ),
              PrimaryTextField(
                title: "Width",
                border: true,
                controller: widthController,
              ),
              SizedBox(
                height: 2.h,
              ),
              PrimaryTextField(
                title: "Additional remarks",
                maxLines: 5,
                border: true,
                controller: notesController,
              ),
              SizedBox(
                height: 3.h,
              ),
              StitchingImageBox(
                  img: img,
                  dummyImg: widget.selectedCat.img,
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
                  title: "Upload Fabric Image"),
              SizedBox(
                height: 3.h,
              ),
              PrimaryGradientButton(
                  title: "Proceed",
                  onPressed: () {
                    Navigator.pushNamed(context, "/stitching-detail",
                        arguments: {
                          "selectedCat": widget.selectedCat,
                          "fabricLength": lengthController.text,
                          "fabricWidth": widthController.text,
                          "name": nameController.text,
                          "note": notesController.text,
                          "image": img
                        });
                  }),
              SizedBox(
                height: 3.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
