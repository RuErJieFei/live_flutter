// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';

import 'group_avatar.dart';

/// 创建时间：2022/11/30
/// 作者：w2gd
/// 描述：

class ConversationTitle extends GetView<MessageController> {
  const ConversationTitle({
    Key? key,
    required this.conversation,
    required this.callback,
  }) : super(key: key);
  final Conversation conversation; // 会话
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final contact = ContactModel().obs;
    // 根据人数来渲染头像
    controller.getMemberId(conversation).then((id) {
      if (conversation.members!.length <= 2) {
        // 私聊
        contact(controller.contactsMap[id]);
      } else {
        // 群聊：显示头像（多人拼图）
        contact.update((e) {
          e?.name = conversation.name;
          // e?.photo = 'http://img.w2gd.top/up/groupChat.png';
        });
      }
    });
    return InkWell(
      onTap: callback,
      child: Container(
        height: 80.h,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 70.r,
                height: 70.r,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                clipBehavior: Clip.antiAlias,
                child: conversation.members!.length <= 2
                    ? Obx(() {
                        return BGPositionImage.positionImage('${contact.value.photo}');
                      })
                    : GroupAvatar(list: conversation.members),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(() {
                        return Text(
                          '${contact.value.name}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        '${controller.getLastMessageInfo(conversation.lastMessage)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      controller.dealDate(conversation.lastMessageDate),
                      style: TextStyle(
                        fontSize: 12.sp,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: conversation.unreadMessageCount == 0 ? 0 : 1, // 未读0 不显示
                      child: Container(
                        width: 21.r,
                        height: 21.r,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${conversation.unreadMessageCount}',
                            style: TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
