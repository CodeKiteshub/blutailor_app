import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/alteration_entity.dart';
import 'package:bluetailor_app/features/alteration/presentation/cubit/alteration_config/alteration_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AlterationConfigWidget extends StatefulWidget {
  final String title;
  final String name;
  final dynamic measurementData;
  final dynamic price;
  const AlterationConfigWidget(
      {super.key,
      required this.title,
      this.measurementData,
      required this.price,
      required this.name});

  @override
  State<AlterationConfigWidget> createState() => _AlterationConfigWidgetState();
}

class _AlterationConfigWidgetState extends State<AlterationConfigWidget> {
  TextEditingController currentController = TextEditingController();
  TextEditingController expectedController = TextEditingController();
  TextEditingController differenceController = TextEditingController();

  @override
  void initState() {
    differenceController.text = "0";
    currentController.text = "0";
    expectedController.text = "0";
    if (widget.measurementData != null) {
      expectedController.text = widget.measurementData.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.title,
                style: TextStyle(
                    color: const Color(0xFF383A3A),
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp)),
            SizedBox(
              width: 2.w,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  color: primaryBlue,
                )),
          ],
        ),
        Text("Change",
            style: TextStyle(
                color: const Color(0xFF757575),
                fontWeight: FontWeight.w500,
                fontSize: 15.sp)),
        SizedBox(
          height: 1.h,
        ),
        Container(
          width: 73.w,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF9D9D9D)),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  differenceController.text = (double.parse(
                              differenceController.text.isEmpty
                                  ? "0"
                                  : differenceController.text) -
                          0.5)
                      .toString();
                  changeExpected();
                  setState(() {});
                },
                child: Icon(Icons.remove,
                    color: double.parse(differenceController.text)
                            .toString()
                            .startsWith("-")
                        ? primaryRed
                        : black2),
              )),
              Expanded(
                  child: TextField(
                controller: differenceController,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: black2),
                onChanged: (value) {
                  changeExpected();
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    fillColor: const Color(0xFFD9D9D9),
                    filled: true,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              )),
              Expanded(
                  child: InkWell(
                onTap: () {
                  differenceController.text = (double.parse(
                              differenceController.text.isEmpty
                                  ? "0"
                                  : differenceController.text) +
                          0.5)
                      .toString();

                  changeExpected();
                  setState(() {});
                },
                child: Icon(Icons.add,
                    color: double.parse(differenceController.text)
                            .toString()
                            .startsWith("-")
                        ? black2
                        : Colors.green),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 35.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Size",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextField(
                    controller: currentController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      changeExpected();
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Size",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFFB6B6B6)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: primaryBlue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Color(0xff9d9d9d)))),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            SizedBox(
              width: 35.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Expected Size",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff757575)),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextField(
                    controller: expectedController,
                    textAlign: TextAlign.center,
                    // onChanged: (value) {
                    //   if (currentController.text == "0" ||
                    //       currentController.text.isEmpty) {
                    //     changCurrent();
                    //   } else {
                    //     changDifference();
                    //   }
                    // },
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: "Enter Size",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: const Color(0xFFB6B6B6)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: primaryBlue)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Color(0xff9d9d9d)))),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  changeExpected() {
    expectedController.text = ((currentController.text.isEmpty
                ? 0
                : double.parse(currentController.text)) +
            double.parse(differenceController.text))
        .toString();
    addToList();
    setState(() {});
  }

  changCurrent() {
    if (expectedController.text.isNotEmpty &&
        expectedController.text != "0.0" &&
        differenceController.text.isNotEmpty &&
        differenceController.text != "0.0" &&
        differenceController.text != "-") {
      currentController.text = (double.parse(expectedController.text) -
              double.parse(differenceController.text))
          .toString();
      addToList();
      setState(() {});
    }
  }

  changDifference() {
    if (expectedController.text.isNotEmpty &&
        expectedController.text != "0" &&
        currentController.text.isNotEmpty &&
        currentController.text != "0") {
      differenceController.text = (double.parse(expectedController.text) -
              double.parse(currentController.text))
          .toString();
      addToList();
      setState(() {});
    }
  }

  addToList() {
    if (double.parse(differenceController.text) == 0 ||
        double.parse(differenceController.text) == 0.0) {
      context
          .read<AlterationConfigCubit>()
          .alterations
          .removeWhere((e) => e.label == widget.title);
    } else {
      if (context
          .read<AlterationConfigCubit>()
          .alterations
          .any((e) => e.label == widget.title)) {
        context
            .read<AlterationConfigCubit>()
            .alterations
            .firstWhere((e) => e.label == widget.title)
            .value = double.parse(differenceController.text);
      } else {
        context.read<AlterationConfigCubit>().alterations.add(AlterationEntity(
            price: widget.price,
            label: widget.title,
            name: widget.name,
            value: double.parse(differenceController.text),
            current: double.parse(currentController.text)));
      }
    }
  }
}
