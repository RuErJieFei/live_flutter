// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wit_niit/app/data/theme_data.dart';

/// 创建时间：2022/11/17
/// 作者：w2gd
/// 我的消息框
class MessageOwnTile extends StatelessWidget {
  const MessageOwnTile({
    Key? key,
    required this.messageDate,
    required this.widget,
  }) : super(key: key);
  final String messageDate;
  final Widget widget;

  static const _borderRadius = 25.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Config.viceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: widget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  color: Config.viceColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 对方的消息框
class MessageTile extends StatelessWidget {
  const MessageTile({
    Key? key,
    required this.widget,
    required this.messageDate,
  }) : super(key: key);

  final Widget widget;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: widget,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 文本消息
class TextMsg extends StatelessWidget {
  final String message;
  const TextMsg({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
    );
  }
}

/// 远程图片消息
class ImgMsg extends StatelessWidget {
  final String? imgUrl;
  const ImgMsg({Key? key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      child: Image.network(imgUrl!),
    );
  }
}

/// 本地图片消息
class ImgFileMsg extends StatelessWidget {
  final String filepath;
  const ImgFileMsg({Key? key, required this.filepath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      child: Image.file(File(filepath)),
    );
  }
}
