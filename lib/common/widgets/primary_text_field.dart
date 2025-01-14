import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final bool border;
  final int maxLines;
  final String? suffixText;
  final TextInputType? keyboardType;
  const PrimaryTextField(
      {super.key, this.controller, required this.title,this.keyboardType, this.border = false, this.maxLines = 1, this.suffixText});

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.title} is required";
        }
        return null;
      },
      style: TextStyle(fontSize: Device.screenType == ScreenType.tablet ? 16.sp : null),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        // constraints: BoxConstraints(
        //   minHeight: 6.h,
        // ),
        enabledBorder: OutlineInputBorder(
            borderSide: widget.border
                ? const BorderSide(color: Color(0xFFC7C7C7))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: primaryBlue,
            )),
        hintText: widget.title,
        hintStyle: TextStyle(
            color: Colors.black.withValues(alpha: 0.27),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
            suffixText: widget.suffixText,
        suffixStyle: TextStyle(
            color: Colors.black.withValues(alpha: 0.27),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
