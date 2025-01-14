
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBoxWidget extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const SearchBoxWidget({
    super.key, required this.enabled, this.onChanged, this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
      child: TextField(
        enabled: enabled,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  color: Color(0xFF979797), width: 0.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  color: Color(0xFF979797), width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  const BorderSide(color: primaryBlue, width: 0.5)),
          prefixIcon: const Icon(CupertinoIcons.search),
        ),
      ),
    );
  }
}
