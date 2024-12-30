import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(CountryCode)? onCountryChanged;
  final bool border;
  const PhoneTextField(
      {super.key, this.controller, this.onCountryChanged, this.border = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 6.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: border ? const Color(0xFFC7C7C7) : Colors.transparent,
              )),
          child: CountryCodePicker(
            onChanged: onCountryChanged,
            padding: EdgeInsets.zero,
            builder: (p0) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  p0!.flagUri!,
                  package: 'country_code_picker',
                  width: 25,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  p0.dialCode!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            initialSelection: 'IN',
            favorite: const ['IN', 'US'],
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Phone number is required";
              }
              if (value.length < 10) {
                return "Phone number is invalid";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              constraints: BoxConstraints(
                minHeight: 6.h,
                maxHeight: 6.h
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: border
                      ? const BorderSide(color: Color(0xFFC7C7C7))
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: primaryBlue,
                  )),
              hintText: "Phone Number",
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.27),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
