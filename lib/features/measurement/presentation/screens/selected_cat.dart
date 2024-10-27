import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SelectedCat extends StatelessWidget {
  final List<SelectedCatModel> selectedCat;
  final bool fromCustom;
  const SelectedCat(
      {super.key, required this.selectedCat, required this.fromCustom});

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
              fromCustom ? "Measurements (Custom)" : "Measurements",
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
            padding: EdgeInsets.only(
              left: 7.w,
              right: 7.w,
              top: 3.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Select the garment you would like to add measurements first",
                    style: TextStyle(
                        color: primaryBlack,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                    "You can return to this screen to continue editing your other selected garments if you are done with any one of them.",
                    style: TextStyle(
                        color: const Color(0xff8a8a8a),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                      itemCount: selectedCat.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              if (fromCustom) {
                                Navigator.pushNamed(
                                    context, "/measurement-details",
                                    arguments: selectedCat[index]);
                              } else {
                                Navigator.pushNamed(context, "/standard-size",
                                    arguments: selectedCat[index].id);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 5.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: const Color(0xffc7c7c7)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      selectedCat[index].label,
                                      style: TextStyle(
                                          fontFamily: 'dmsans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: primaryBlack),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                        color: primaryBlue,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Container(
                                        height: 4.w,
                                        width: 4.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.white),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12.sp,
                                          color: Colors.white,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ))
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          height: 6.h,
          margin: EdgeInsets.only(
            left: 5.w,
            right: 5.w,
          ),
          child: PrimaryGradientButton(title: "Proceed", onPressed: () {})),
    );
  }
}