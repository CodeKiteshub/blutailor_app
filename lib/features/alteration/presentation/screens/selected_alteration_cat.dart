import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/selected_alteration_cat_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class SelectedAlterationCat extends StatelessWidget {
  final List<SelectedAlterationCatEntity> selectedCat;
  const SelectedAlterationCat({super.key, required this.selectedCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Alteration"),
      body: Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          children: [
            Text("Select the garment you want to get alter",
                style: TextStyle(
                    color: primaryBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(
              height: 2.h,
            ),
            ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                      height: 1.h,
                    ),
                itemCount: selectedCat.length,
                itemBuilder: (context, index) {
                  return ExpandablePanel(
                      theme: const ExpandableThemeData(hasIcon: false),
                      header: Row(
                        children: [
                          CachedNetworkImage(imageUrl: selectedCat[index].img,
                          height: 15.h,),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${selectedCat[index].label} Stitching",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: black2,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "${selectedCat[index].length} Garments",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: black2,
                                    fontSize: 16.sp),
                              ),
                            ],
                          )),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: black2,
                          )
                        ],
                      ),
                      collapsed: const SizedBox.shrink(),
                      expanded: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 2.h,
                              ),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          itemCount: selectedCat[index].length,
                          itemBuilder: (context, indx) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/alteration-option',
                                    arguments: selectedCat[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFEDEDED),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 4))
                                    ]),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(hanger),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "${selectedCat[index].label} ${indx + 1}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: black2),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
                })
          ],
        ),
      ),
    );
  }
}
