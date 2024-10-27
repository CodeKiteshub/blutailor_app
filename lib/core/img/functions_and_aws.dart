import 'dart:developer';
import 'dart:io';

import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future<CroppedFile?> cropImg(XFile pickedfile) async {
  try {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedfile.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: primaryBlue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile!;
  } catch (e) {
    return null;
  }
}

// Upload to AWS

Future<String?> uploadToAWS(
    String image, String url) async {
  try {
    var bytes = await File(image).readAsBytes();
    var response = await http
        .put(Uri.parse(url), body: bytes);
    if (response.statusCode == 200) {
      return url.split("?").first;
    } else {
      return null;
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}
