import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicInfoTile extends StatelessWidget {
  String? title;
  String? content;

  BasicInfoTile({Key? key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
      child: Row(
        children: [
          Container(
              width: 0.3.sw,
              child: Text(
                this.title!,
                maxLines: 1,
                style: TextStyle(fontSize: 16.sp),
              )),
          Container(
              width: 0.6.sw,
              child: Text(
                this.content!,
                maxLines: 1,
                style: TextStyle(fontSize: 16.sp),
              ))
        ],
      ),
    );
  }
}
