import 'package:bluetailor_app/common/widgets/dialog_and_snackbar.dart.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_stitching_cat_entity.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/selected_styling_entity.dart';
import 'package:bluetailor_app/features/stitching/presentation/cubit/stitching_cubit/stitching_cubit.dart';
import 'package:bluetailor_app/features/stitching/presentation/cubit/styling_cubit/styling_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class StitchingDetail extends StatefulWidget {
  final SelectedStitchingCatEntity selectedCat;
  final String fabricLength;
  final String fabricWidth;
  final String name;
  final String note;
  final String image;
  const StitchingDetail(
      {super.key,
      required this.selectedCat,
      required this.fabricLength,
      required this.fabricWidth,
      required this.name,
      required this.note,
      required this.image});

  @override
  State<StitchingDetail> createState() => _StitchingDetailState();
}

class _StitchingDetailState extends State<StitchingDetail> {
  bool isCustom = false;
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<StylingCubit>(context)
        .fetchStyling(catId: widget.selectedCat.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.selectedCat.img,
                    height: 30.h,
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 2.h,
                    left: 5.w,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        backIcon,
                        color: primaryBlue,
                        height: 2.5.h,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: black2),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  widget.note,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: const Color(0xFF7D7D7D)),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Divider(
                thickness: 1.h,
                color: const Color(0xFFE3E3E3),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          primaryGradient.createShader(bounds),
                      child: Text(
                        "Styling",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            isCustom = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: isCustom ? Colors.white : primaryBlue,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4)
                                ]),
                            child: Text(
                              "Standard",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: isCustom ? black2 : Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            isCustom = true;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: isCustom ? primaryBlue : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4)
                                ]),
                            child: Text(
                              "Custom",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: isCustom ? Colors.white : black2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    if (isCustom)
                      BlocBuilder<StylingCubit, StylingState>(
                          builder: (context, state) {
                        if (context
                            .read<StylingCubit>()
                            .selectedStylingList
                            .isEmpty) {
                          return Column(
                            children: [
                              Text(
                                'No Styling Found. Tap on the button below to add styling',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                    color: const Color(0xFF49454F)),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/custom_filter",
                                      arguments: context
                                          .read<StylingCubit>()
                                          .customStyling);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4)
                                      ]),
                                  child: Text(
                                    "Add Styling",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              MasonryGridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 2.h,
                                  crossAxisSpacing: 3.w,
                                  itemCount: context
                                      .read<StylingCubit>()
                                      .selectedStylingList
                                      .length,
                                  itemBuilder: (context, index) {
                                    final custom = context
                                        .read<StylingCubit>()
                                        .selectedStylingList[index];
                                    return Container(
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: primaryBlue))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (bounds) =>
                                                primaryGradient
                                                    .createShader(bounds),
                                            child: Text(
                                              custom.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            custom.label,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: black2),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 3.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/custom_filter",
                                      arguments: context
                                          .read<StylingCubit>()
                                          .customStyling);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4)
                                      ]),
                                  child: Text(
                                    "Edit Styling",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      })
                    else
                      MasonryGridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          mainAxisSpacing: 2.h,
                          crossAxisSpacing: 3.w,
                          itemCount: ((context
                                          .read<StylingCubit>()
                                          .standardJson["categories"] as List)
                                      .firstWhere((e) =>
                                          e["id"] == widget.selectedCat.id)[
                                  "defaultConfig"] as List)
                              .length,
                          itemBuilder: (context, index) {
                            final standard = ((context
                                        .read<StylingCubit>()
                                        .standardJson["categories"] as List)
                                    .firstWhere((e) =>
                                        e["id"] ==
                                        widget.selectedCat.id)["defaultConfig"]
                                as List)[index];
                            return Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: primaryBlue))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        primaryGradient.createShader(bounds),
                                    child: Text(
                                      standard["name"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    standard["value"],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: black2),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              ),
                            );
                          }),
                    SizedBox(
                      height: 3.h,
                    ),
                    PrimaryTextField(
                        title: "Additional Remark",
                        controller: remarkController,
                        border: true,
                        maxLines: 5)
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: BlocListener<StitchingCubit, StitchingState>(
          listener: (context, state) {
            if (state is StitchingLoading) {
              LoadingDialog(context);
            }
            if (state is StitchingSaved) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              PrimarySnackBar(
                  context, "Your stitching order is saved.", Colors.green);
            }
            if (state is StitchingError) {
              Navigator.pop(context);
              PrimarySnackBar(context, state.message, Colors.red);
            }
            if (state is StitchingSignedUrlError) {
              Navigator.pop(context);
              PrimarySnackBar(context, "Image upload error", Colors.red);
            }
          },
          child: PrimaryGradientButton(
              title: "Add to Cart",
              onPressed: () {
                if (isCustom) {
                  context.read<StitchingCubit>().saveStiching(
                      catId: widget.selectedCat.id,
                      fabricName: widget.name,
                      fabricImage: widget.image,
                      fabricLength: double.parse(widget.fabricLength),
                      fabricWidth: double.parse(widget.fabricWidth),
                      fabricNote: widget.note,
                      stylingNote: remarkController.text,
                      styling:
                          context.read<StylingCubit>().selectedStylingList);
                } else {
                  context.read<StitchingCubit>().saveStiching(
                      catId: widget.selectedCat.id,
                      fabricName: widget.name,
                      fabricImage: widget.image,
                      fabricLength: double.parse(widget.fabricLength),
                      fabricWidth: double.parse(widget.fabricWidth),
                      fabricNote: widget.note,
                      stylingNote: remarkController.text,
                      styling: ((context
                                      .read<StylingCubit>()
                                      .standardJson["categories"] as List)
                                  .firstWhere(
                                      (e) => e["id"] == widget.selectedCat.id)[
                              "defaultConfig"] as List)
                          .map((e) => SelectedStylingEntity(
                              catTag: "",
                              name: "",
                              label: e["name"],
                              value: e["value"]))
                          .toList());
                }
              }),
        ),
      ),
    );
  }
}
