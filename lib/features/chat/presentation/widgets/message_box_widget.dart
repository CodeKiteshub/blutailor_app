// ignore_for_file: use_build_context_synchronously

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageBoxWidget extends StatelessWidget {
  final String message;
  const MessageBoxWidget({super.key, required this.message});

  bool hasURLs(String text) {
    const pattern =
        r"(https?:\/\/(www.)?|www.)([\w-]+.([\w-]+.)?[\w]+)([\w./?=%-]*)";
    final regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }

  bool containsPhoneNumber(String input) {
    // Regular expression pattern for a basic phone number
    const pattern = r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b';

    // Create a regular expression object
    final regex = RegExp(pattern);

    // Check if the input matches the pattern
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            children: message.split(" ").map((e) {
      if (hasURLs(e)) {
        return TextSpan(
          text: "$e ",
          style: TextStyle(
            fontSize: 15.sp,
            color: primaryRed,
            fontWeight: FontWeight.w500,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              // Handle link - here we use `url_launcher`
              var word = e.startsWith("http") ? e : "https://$e";

              if (!await launchUrl(Uri.parse(word))) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Could not launch")));

                throw Exception('Could not launch $word');
              }
            },
        );
      } else if (containsPhoneNumber(e)) {
        return TextSpan(
          text: "$e ",
          style:  TextStyle(
            fontSize: 15.sp,
            color: primaryRed,
            fontWeight: FontWeight.w500,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              // Handle link - here we use `url_launcher`
              String telephoneUrl = "tel:+$e";

              if (!await launchUrl(Uri.parse(telephoneUrl))) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Could not launch")));
                throw Exception('Could not launch $telephoneUrl');
              }
            },
        );
      } else {
        return TextSpan(
          text: "$e ",
          style:  TextStyle(
            fontSize: 15.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        );
      }
    }).toList()));
  }
}
