import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  /// 键盘亮度(暗黑和正常)这里默认正常
  final bool isLight;

  ///控制器，控制TextField文字
  final TextEditingController? controller;

  /// 最小行数
  final int? minLines;

  /// 最大行数
  final int? maxLines;

  /// 输入文本样式
  final TextStyle? style;

  /// 边框装饰
  final InputDecoration? decoration;

  /// 键盘类型(默认文本)
  final TextInputType? keyboardType;

  /// 光标颜色
  final Color? cursorColor;

  /// 是否隐藏内容，例如密码格式
  final bool obscureText;

  /// 是否自动对焦
  final bool autofocus;

  /// 验证及格式
  final List<TextInputFormatter>? inputFormatters;

  /// 允许输入的最大长度
  final int? maxLength;

  ///控制键盘动作
  final TextInputAction? textInputAction;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;

  MyTextField({
    this.isLight: true,
    this.controller,
    this.minLines,
    this.maxLines,
    this.style,
    this.decoration,
    this.keyboardType,
    this.cursorColor,
    this.obscureText: false,
    this.autofocus: false,
    this.inputFormatters,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardAppearance: (widget.isLight) ? Brightness.light : Brightness.dark,
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: widget.style,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      cursorColor: widget.cursorColor,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      autofocus: widget.autofocus,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
