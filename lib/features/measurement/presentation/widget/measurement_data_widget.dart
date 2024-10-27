// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bluetailor_app/features/measurement/presentation/cubit/product_config/product_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:bluetailor_app/common/widgets/primary_text_field.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';

class MeasurementDataWidget extends StatefulWidget {
  TextEditingController? inchController;
  TextEditingController? cmController;

  final String title;
  final bool isInch;
  final String? previouesValue;
  MeasurementDataWidget({
    super.key,
    this.inchController,
    this.cmController,
    required this.title,
    required this.isInch,
    this.previouesValue,
  });

  @override
  State<MeasurementDataWidget> createState() => _MeasurementDataWidgetState();
}

class _MeasurementDataWidgetState extends State<MeasurementDataWidget> {
  @override
  void initState() {
    if (widget.previouesValue != null) {
      if (widget.cmController!.text.isEmpty) {
        widget.cmController!.text = widget.previouesValue!;
      }
      if (widget.inchController!.text.isEmpty) {
        if (widget.previouesValue!.endsWith(".5")) {
          widget.inchController!.text = widget.previouesValue!.split(".").first;

          BlocProvider.of<ProductConfigCubit>(context)
              .answers
              .firstWhere((element) => element.label == widget.title)
              .selectedDropDownValue = "0.5";
        } else if (widget.previouesValue!.endsWith(".25")) {
          widget.inchController!.text = widget.previouesValue!.split(".").first;

          BlocProvider.of<ProductConfigCubit>(context)
              .answers
              .firstWhere((element) => element.label == widget.title)
              .selectedDropDownValue = "0.25";
        } else if (widget.previouesValue!.endsWith(".75")) {
          BlocProvider.of<ProductConfigCubit>(context)
              .answers
              .firstWhere((element) => element.label == widget.title)
              .selectedDropDownValue = "0.75";
          widget.inchController!.text = widget.previouesValue!.split(".").first;
        } else {
          widget.inchController!.text =
              double.parse(widget.previouesValue!).toInt().toString();
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: primaryBlack),
        ),
        SizedBox(
          height: 1.h,
        ),
        !widget.isInch
            ? PrimaryTextField(
                title: "",
                border: true,
                controller: widget.cmController,
              )
            : Row(
                children: [
                  Expanded(
                      child: PrimaryTextField(
                    controller: widget.inchController,
                    border: true,
                    title: "",
                  )),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    constraints: BoxConstraints(minHeight: 6.5.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffc7c7c7)),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton<String>(
                        items: [
                          DropdownMenuItem(
                              value: "0",
                              child: Text(
                                "0",
                                style: TextStyle(
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xff444444)),
                              )),
                          DropdownMenuItem(
                              value: "0.5",
                              child: Text(
                                "1/2",
                                style: TextStyle(
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xff444444)),
                              )),
                          DropdownMenuItem(
                              value: "0.25",
                              child: Text(
                                "1/4",
                                style: TextStyle(
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xff444444)),
                              )),
                          DropdownMenuItem(
                              value: "0.75",
                              child: Text(
                                "3/4",
                                style: TextStyle(
                                    fontFamily: 'dmsans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                    color: const Color(0xff444444)),
                              )),
                        ],
                        iconEnabledColor: const Color(0xff444444),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        underline: Container(),
                        value: BlocProvider.of<ProductConfigCubit>(context)
                            .answers
                            .firstWhere(
                                (element) => element.label == widget.title)
                            .selectedDropDownValue,
                        onChanged: (value) {
                          BlocProvider.of<ProductConfigCubit>(context)
                              .answers
                              .firstWhere(
                                  (element) => element.label == widget.title)
                              .selectedDropDownValue = value;
                          setState(() {});
                        }),
                  )),
                ],
              )
      ],
    );
  }
}
