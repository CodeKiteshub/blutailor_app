import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/selected_alteration_cat_entity.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/save_alteration/save_alteration_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AlterationOrderSummary extends StatelessWidget {
  final SelectedAlterationCatEntity selectedCat;
  final List<AlterationEntity> alterations;
  final String imgFile;
  final String videoFile;
  const AlterationOrderSummary(
      {super.key,
      required this.alterations,
      required this.imgFile,
      required this.videoFile,
      required this.selectedCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Alteration"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Order Summary",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: black2),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                            height: 1.h,
                          ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: alterations.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Radio(
                                value: true,
                                groupValue: true,
                                onChanged: (value) {}),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              child: Text(
                                "${alterations[index].label} - Rs.${alterations[index].price}/-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: black2),
                              ),
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
            Divider(
              color: const Color(0xffe3e3e3),
              thickness: 2.h,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alteration Details",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: black2),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alterations[index].label,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: black2),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    alterations[index].current.toString() + '"',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: black2),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: black2,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    (alterations[index].current +
                                                alterations[index].value)
                                            .toString() +
                                        '"',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: alterations[index]
                                                .value
                                                .toString()
                                                .startsWith("-")
                                            ? primaryRed
                                            : Colors.green),
                                  ),
                                ],
                              )
                            ],
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 2.h,
                          ),
                      itemCount: alterations.length),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: const Color(0XFFF4F4F4),
                        border: Border.all(color: const Color(0xFFE3E3E3)),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: black2),
                        ),
                        Text(
                          alterations
                              .fold(
                                  0.0,
                                  (previousValue, element) =>
                                      previousValue + element.price.toDouble())
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: black2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: BlocListener<SaveAlterationCubit, SaveAlterationState>(
          listener: (context, state) {
            if (state is SaveAlterationLoading) {
              LoadingDialog(context);
            }
            if (state is SavedAlteration) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              PrimarySnackBar(
                  context, "Your alteration is saved.", Colors.green);
            }
            if (state is SaveAlterationError) {
              Navigator.pop(context);
              PrimarySnackBar(context, "Something went wrong", Colors.red);
            }
          },
          child: PrimaryGradientButton(
              title: "Add to Cart",
              onPressed: () {
                context.read<SaveAlterationCubit>().saveAlteration(
                    catId: selectedCat.id,
                    catName: selectedCat.label,
                    imgFile: imgFile,
                    videoFile: videoFile,
                    alterations: alterations);
              }),
        ),
      ),
    );
  }
}
