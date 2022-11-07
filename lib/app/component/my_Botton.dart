// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bg_gradinent.dart';

/// 创建时间：2022/10/24
/// 作者：w2gd
/// 描述：封装一个渐变色按钮

class MyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  const MyButton({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: BGGradient(
        alignment: Alignment.center,
        height: 48.h,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
