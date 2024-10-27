import 'package:bluetailor_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageInputWidget extends StatelessWidget {
  const MessageInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      color: primaryBlue,
      child: Row(
        children: [
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: TextField(
              //  controller: messageController,
              //  enabled: file == null || file!.path == "" ? true : false,
              minLines: 1,
              maxLines: 3,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  constraints: BoxConstraints(minHeight: 1.h, maxHeight: 100),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {},
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        PopupMenuButton(
                          color: primaryBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: InkWell(
                              onTap: () async {},
                              child: const ListTile(
                                leading: Icon(
                                  Icons.videocam,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "Video",
                                  style: TextStyle(
                                      fontFamily: 'dmsans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                minLeadingWidth: 0.0,
                              ),
                            )),
                            PopupMenuItem(
                                child: InkWell(
                              onTap: () async {},
                              child: const ListTile(
                                leading: Icon(
                                  Icons.note,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "Document",
                                  style: TextStyle(
                                      fontFamily: 'dmsans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                minLeadingWidth: 0.0,
                              ),
                            )),
                            PopupMenuItem(
                                child: InkWell(
                              onTap: () async {},
                              child: const ListTile(
                                leading: Icon(
                                  Icons.photo,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  "Image",
                                  style: TextStyle(
                                      fontFamily: 'dmsans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                minLeadingWidth: 0.0,
                              ),
                            ))
                          ],
                          child: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.attachment_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                      ],
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(width: 3.w),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xff3FB87B), shape: BoxShape.circle),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              )),
          SizedBox(width: 2.w)
        ],
      ),
    );
  }
}
