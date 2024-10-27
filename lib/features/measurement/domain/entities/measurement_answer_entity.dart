import 'package:flutter/material.dart';

class MeasurementAnswerEntity {
  String label;
  TextEditingController? inchController;
  String? selectedDropDownValue;
  TextEditingController? cmController;

  MeasurementAnswerEntity(
      {required this.label,
      this.inchController,
      this.cmController,
      this.selectedDropDownValue});

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "value": inchController!.text.isEmpty
          ? double.parse(cmController!.text.isEmpty ? "0" : cmController!.text)
          : double.parse(inchController!.text) +
              double.parse(selectedDropDownValue!)
    };
  }
}
