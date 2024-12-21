import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  final bool border;
  final int maxLines;
  const PrimaryTextField(
      {super.key, this.controller, required this.title, this.border = false, this.maxLines = 1});

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.title} is required";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        constraints: BoxConstraints(
          minHeight: 6.h,
        ),
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
            color: Colors.black.withOpacity(0.27),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
