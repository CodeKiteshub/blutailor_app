import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/stitching/domain/entities/styling_config_entity.dart';
import 'package:bluetailor_app/features/stitching/presentation/cubit/styling_cubit/styling_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class CustomFilter extends StatefulWidget {
  final List<StylingConfigEntity> styling;
  const CustomFilter({super.key, required this.styling});

  @override
  State<CustomFilter> createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  String masterName = "";

  @override
  void initState() {
    if (widget.styling.isNotEmpty) {
      masterName = widget.styling.first.masterName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Stitching"),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: widget.styling.isEmpty
            ? Center(
              child: Text(
                  "No styling option found",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: Colors.black),
                ),
            )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colors.black),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ]),
                        child: DropdownButton(
                            items: widget.styling
                                .map((e) => DropdownMenuItem(
                                    value: e.masterName,
                                    child: Text(
                                      e.label,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.sp,
                                          color: Colors.white),
                                    )))
                                .toList(),
                            underline: Container(),
                            iconEnabledColor: Colors.white,
                            dropdownColor: primaryBlue,
                            borderRadius: BorderRadius.circular(5),
                            value: masterName,
                            onChanged: (value) {
                              masterName = value!.toString();
                              setState(() {});
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: MasonryGridView.count(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10.h),
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.h,
                        mainAxisSpacing: 3.h,
                        itemCount: widget.styling.isEmpty
                            ? 0
                            : widget.styling
                                .firstWhere((e) => e.masterName == masterName)
                                .options
                                .length,
                        itemBuilder: (context, index) {
                          final option = widget.styling
                              .firstWhere((e) => e.masterName == masterName)
                              .options[index];
                          return InkWell(
                            onTap: () {
                              context
                                  .read<StylingCubit>()
                                  .saveStyling(masterName, option);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  gradient: context
                                          .read<StylingCubit>()
                                          .selectedStylingList
                                          .any((e) => e.value == option.id)
                                      ? borderGradient
                                      : null,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                          imageUrl: option.image ??
                                       "https://cdn-icons-png.flaticon.com/512/12225/12225935.png",   )),
                                  Positioned(
                                    left: 3.w,
                                    bottom: 1.h,
                                    child: Text(
                                      option.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp,
                                          color: primaryBlack),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: widget.styling.isEmpty ?
        const SizedBox.shrink()
        : PrimaryGradientButton(
            title: "Save",
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
