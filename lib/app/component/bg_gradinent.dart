import 'package:flutter/material.dart';
import 'package:wit_niit/app/data/theme_data.dart';

/// 背景渐变
class BGGradient extends StatelessWidget {
  const BGGradient({
    Key? key,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.child,
    this.margin,
    this.alignment,
  }) : super(key: key);

  ///宽度
  final double? width;

  ///高度
  final double? height;

  ///四周圆角
  final BorderRadiusGeometry? borderRadius;

  ///边框
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
        gradient: const LinearGradient(
          colors: [Config.viceColor, Config.mainColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
