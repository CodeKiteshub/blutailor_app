import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:bluetailor_app/common/cubit/body_profile/body_profile_cubit.dart';
import 'package:bluetailor_app/common/cubit/user_attribue/user_attribute_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class BodyItemWidget extends StatefulWidget {
  final String title;
  final String? selectedId;
  const BodyItemWidget({super.key, required this.title, this.selectedId});

  @override
  State<BodyItemWidget> createState() => _BodyItemWidgetState();
}

class _BodyItemWidgetState extends State<BodyItemWidget> {
  String selectedId = "";

  @override
  void initState() {
    if (widget.selectedId != null) {
      selectedId = widget.selectedId!;
      setState(() {});
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
            Text(
              widget.title,
              style: TextStyle(
                color: const Color(0xff757575),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            const Icon(Icons.help_outline, color: Color(0xff757575), size: 15)
          ],
        ),
        Text(
          "select the type you identify with",
          style: TextStyle(
            color: const Color(0xff8a8a8a),
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          height: 15.h,
          child: BlocBuilder<UserAttributeCubit, UserAttributeState>(
            builder: (context, state) {
              if (state is UserAttributeLoaded) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                          width: 3.w,
                        ),
                    itemCount: state.userAttributes.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (selectedId ==
                            state.userAttributes[index].id) {
                          selectedId = "";
                        } else {
                          selectedId = state.userAttributes[index].id;
                        }
                           if (widget.title.toLowerCase().contains("shoulder")) {
                                BlocProvider.of<BodyProfileCubit>(context)
                                    .shoulderTypeId = selectedId;
                              }
                              if (widget.title.toLowerCase().contains("posture")) {
                                BlocProvider.of<BodyProfileCubit>(context)
                                    .bodyPostureId = selectedId;
                              }
                              if (widget.title.toLowerCase().contains("shape")) {
                                BlocProvider.of<BodyProfileCubit>(context)
                                    .bodyShapeId = selectedId;
                              }
                              if (widget.title.toLowerCase().contains("fit")) {
                                BlocProvider.of<BodyProfileCubit>(context)
                                    .fitPreferenceId = selectedId;
                              }
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 10.h,
                            width: 20.w,
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              gradient: selectedId ==
                                      state.userAttributes[index].id
                                  ? borderGradient
                                  : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state.userAttributes[index].image,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            state.userAttributes[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: const Color(0xff757575),
                            ),
                          ),
                        ],
                      ),
                    ));
              }
              return LoadingAnimationWidget.waveDots(
                  color: Colors.white, size: 50);
            },
          ),
        )
      ],
    );
  }
}
