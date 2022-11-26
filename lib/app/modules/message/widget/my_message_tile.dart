// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/image_show_server.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/widget/avatar.dart';

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

  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    UserModel? myInfo = SpUtil.getObj("user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Padding(
      padding: EdgeInsets.only(right: 4, left: 50.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
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
                    ],
                  ),
                ),
                SizedBox(width: 7),
                Column(
                  children: [
                    Avatar.medium(url: '${myInfo?.photo}'),
                    Text(messageDate,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Config.viceColor,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 对方的消息框
class MessageTile extends GetView<MessageController> {
  const MessageTile({
    Key? key,
    required this.widget,
    required this.messageDate,
    required this.senderId,
  }) : super(key: key);

  final Widget widget;
  final String messageDate;
  final String? senderId;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    ContactModel sender = controller.contactsMap[senderId] as ContactModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Avatar.medium(url: '${sender.photo}'),
                    Text(messageDate, style: TextStyle(fontSize: 10.sp)),
                  ],
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Offstage(
                        // 根据当前打开的会话人数判断是否显示名字
                        offstage: controller.currentConv.members!.length > 2 ? false : true,
                        child: Text('${sender.name}', style: TextStyle(fontSize: 13.sp)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(_borderRadius),
                            bottomRight: Radius.circular(_borderRadius),
                            bottomLeft: Radius.circular(_borderRadius),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          child: widget,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 文本消息: 0我的， 1其他人
class TextMsg extends StatelessWidget {
  final String message;
  final int type;
  const TextMsg({Key? key, required this.message, this.type = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(color: type == 0 ? Colors.white : null, fontSize: 16.sp),
    );
  }
}

/// 远程图片消息
class ImgNetMsg extends StatelessWidget {
  final String? imgUrl;
  const ImgNetMsg({Key? key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      child: GestureDetector(
        onTap: () {
          // 查看大图
          List _showList = [imgUrl];
          Get.to(
            () => ImageShowServer(
              type: 1,
              photoList: _showList,
            ),
          );
        },
        child: Image.network(imgUrl!),
      ),
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
      child: GestureDetector(
        onTap: () {
          // 查看大图
          List _showList = [filepath];
          Get.to(
            () => ImageShowServer(photoList: _showList),
          );
        },
        child: Image.file(File(filepath)),
      ),
    );
  }
}
