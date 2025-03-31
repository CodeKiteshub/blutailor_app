
import 'package:bluetailor_app/common/widgets/primary_app_bar.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/features/alteration/domain/entities/selected_alteration_cat_entity.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlterationOption extends StatefulWidget {
  final SelectedAlterationCatEntity selectedCat;
  final Function onTap;
  const AlterationOption({super.key, required this.selectedCat, required this.onTap});

  @override
  State<AlterationOption> createState() => _AlterationOptionState();
}

class _AlterationOptionState extends State<AlterationOption> {
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimaryAppBar(title: "Alteration"),
      body: Padding(
        padding: EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.selectedCat.label} Alteration",
              style: TextStyle(
                  color: const Color(0xFF383A3A),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            RadioListTile(
                value: 0,
                groupValue: groupValue,
                title: Text("I know the alterations",
                    style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  groupValue = value as int;
                  setState(() {});
                }),
            RadioListTile(
                value: 1,
                groupValue: groupValue,
                title: Text("I have a sample shirt for reference",
                    style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  groupValue = value as int;
                  setState(() {});
                }),
            RadioListTile(
                value: 2,
                groupValue: groupValue,
                title: Text("Need to show to tailor",
                    style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  groupValue = value as int;
                  setState(() {});
                }),
            RadioListTile(
                value: 3,
                groupValue: groupValue,
                title: Text("Connect with support",
                    style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  groupValue = value as int;
                  setState(() {});
                }),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(
            title: "Proceed",
            onPressed: () {
              if (groupValue == 0 || groupValue == 1) {
                Navigator.pushNamed(context, '/upload-image',
                    arguments: {
                      "selectedCat": widget.selectedCat,
                      "onTap": widget.onTap
                    });
              } else {
                Navigator.pushNamed(context, "/create-appointment",
                    arguments: true);
              }
            }),
      ),
    );
  }
}
