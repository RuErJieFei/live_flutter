import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wit_niit/app/data/school_theme_data.dart';

class BaseStyle {
  /// 字号
  static TextStyle fs14 = TextStyle(fontSize: 14.sp);
  static TextStyle fs14bold =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold);
  static TextStyle fs16 = TextStyle(fontSize: 16.sp);
  static TextStyle fs16bold =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold);
  static TextStyle fs26 =
      TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold);

  /// 样式
  static TextStyle wdStyle = TextStyle(color: Colors.pink, fontSize: 30.sp);

  /// 顶部导航字体样式(浅色
  static TextStyle topStyle = TextStyle(color: Colors.white, fontSize: 20.sp);

  /// 灰色中号字体
  static TextStyle grayContentStyle =
      TextStyle(color: Colors.grey.shade700, fontSize: 16.sp);

  /// 灰色小号字体
  static TextStyle graySmallStyle =
      TextStyle(color: Colors.grey.shade500, fontSize: 14.sp);

  /// 黑色中号字体
  static TextStyle contentStyle =
      TextStyle(color: Colors.black, fontSize: 16.sp);

  /// 黑色小号字体
  static TextStyle smallStyle = TextStyle(color: Colors.black, fontSize: 14.sp);

  /// 黑色小号加粗字体
  static TextStyle smallBBoldStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  /// 深灰小号字体加粗
  static TextStyle smallBoldStyle = TextStyle(
    color: Colors.grey.shade700,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  /// 智慧入校主题色中号字体
  static TextStyle schoolContentStyle =
      TextStyle(color: SchoolConfig.primaryColor, fontSize: 16.sp);

  /// 智慧入校主题色中号加粗字体
  static TextStyle schoolBoldContentStyle = TextStyle(
    color: SchoolConfig.primaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  /// 智慧入校主题色小号加粗字体
  static TextStyle schoolBoldSmallStyle = TextStyle(
    color: SchoolConfig.primaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  /// 智慧入校主题色小号字体
  static TextStyle schoolSmallStyle =
      TextStyle(color: SchoolConfig.primaryColor, fontSize: 14.sp);
}
