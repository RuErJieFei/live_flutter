import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wit_niit/app/data/school_theme_data.dart';

/// 创建时间：2022/10/24
/// 作者：crq
/// 描述：封装一个表单提交按钮

class SchoolPushButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const SchoolPushButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 48.h,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: SchoolConfig.primaryColor),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
