import 'package:bluetailor_app/common/models/selected_cat_model.dart';
import 'package:bluetailor_app/common/widgets/app_bar_widget.dart';
import 'package:bluetailor_app/common/widgets/primary_gradient_button.dart';
import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AlterationOption extends StatefulWidget {
  final SelectedCatModel selectedCat;
  const AlterationOption({super.key, required this.selectedCat});

  @override
  State<AlterationOption> createState() => _AlterationOptionState();
}

class _AlterationOptionState extends State<AlterationOption> {

  int groupValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(),
          Padding(
            padding: EdgeInsets.only(left: 3.w, top: 2.h),
            child: Text(
              "Alteration",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding:
                  EdgeInsets.only(left: 7.w, right: 7.w, top: 3.h, bottom: 3.h),
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
                      value: 0, groupValue: groupValue, 
                      title: Text("I know the alterations", style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                        contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        groupValue = value as int;
                        setState(() {});
                      }),
                    
                  RadioListTile(
                      value: 1, groupValue: groupValue, 
                      title: Text("I have a sample shirt for reference", style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                        contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        groupValue = value as int;
                        setState(() {});
                      }),
                    
                  RadioListTile(
                      value: 2, groupValue: groupValue, 
                      title: Text("Need to show to tailor", style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                        contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        groupValue = value as int;
                        setState(() {});
                      }),
                  
                  RadioListTile(
                      value: 3, groupValue: groupValue, 
                      title: Text("Connect with support", style: TextStyle(
                        color: const Color(0xFF383A3A),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp)),
                        contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        groupValue = value as int;
                        setState(() {});
                      }),
                      SizedBox(height: 1.h,),
                ],
              ),
            ),
          )
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BottomAppBar(
        color: Colors.transparent,
        child: PrimaryGradientButton(title: "Proceed", onPressed: () {
          Navigator.pushNamed(context, '/upload-image', arguments: widget.selectedCat);
        }),
      ),
    );
  }
}
