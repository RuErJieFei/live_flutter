import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/message/controllers/chat_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/chatmenu_item.dart';
import 'package:wit_niit/app/modules/message/views/conversation_info_view.dart';
import 'package:wit_niit/app/modules/message/widget/glowing_action_button.dart';
import 'package:wit_niit/app/modules/message/widget/icon_background.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key, required this.conversation, required this.titleName}) : super(key: key);
  final String titleName;
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    controller.ConvName.value = titleName;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        elevation: 0,
        leadingWidth: 54.w,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Obx(() {
          return _AppBarTitle(name: controller.ConvName.value);
        }),
        actions: [
          IconButton(
            onPressed: () {
              EasyLoading.showToast('该功能还未实现');
            },
            icon: Icon(Icons.video_camera_front, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => ConversationInfoView(conversation));
            },
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _MessageList()),
          _ActionBar(conversation),
        ],
      ),
    );
  }
}

/// 聊天内容渲染
class _MessageList extends GetView<ChatController> {
  const _MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var msgCto = Get.find<MessageController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // 关闭键盘
        controller.hiddenMenu.value = true; // 隐藏菜单
        controller.hiddenEmoji.value = true; // 隐藏 emoji
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Obx(() {
          return ListView(
            reverse: true,
            controller: controller.scrollCto,
            children: msgCto.recordList,
          );
        }),
      ),
    );
  }
}

/// 顶部Appbar
class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20.sp),
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// 底部操作栏
class _ActionBar extends GetView<ChatController> {
  final Conversation conversation;

  const _ActionBar(this.conversation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ImageIcon(AssetImage('images/public/voice.png'), size: 30),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    controller: controller.msgTf,
                    onChanged: (v) {
                      if (v.length > 0) {
                        controller.hasContent.value = true;
                      } else {
                        controller.hasContent.value = false;
                      }
                    },
                    onTap: () {
                      controller.hiddenMenu.value = true; // 隐藏菜单
                      controller.hiddenEmoji.value = true; // 隐藏emoji
                      // controller.scrollToBottom(); // 滚动到底部
                    },
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode()); // 关闭键盘
                    controller.hiddenEmoji.value = false; // 显示emoji
                    controller.hiddenMenu.value = true; // 隐藏菜单
                    // controller.scrollToBottom();
                  },
                  child: Image.asset('images/public/emoji.png', width: 40.w),
                ),
              ),
              Container(
                width: 60.w,
                padding: const EdgeInsets.only(left: 6, right: 14.0),
                child: Obx(() {
                  return controller.hasContent.value
                      ? GlowingActionButton(
                          color: Config.mainColor,
                          icon: Icons.send_rounded,
                          size: 40.w,
                          onPressed: () {
                            controller.sendMsg(conversation);
                          },
                        )
                      : IconButton(
                          onPressed: () {
                            controller.hiddenMenu.value = false; // 显示菜单
                            controller.hiddenEmoji.value = true; // 隐藏emoji
                            FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
                            // controller.scrollToBottom(); // 滚动到底部
                          },
                          icon: Icon(Icons.add_circle_outline, size: 35.w),
                        );
                }),
              ),
            ],
          ),
          Obx(() {
            return Offstage(offstage: controller.hiddenMenu.value, child: _menu());
          }),
          Obx(() {
            return Offstage(offstage: controller.hiddenEmoji.value, child: _emojiMenu());
          }),
        ],
      ),
    );
  }

  /// 底部菜单
  Widget _menu() {
    /// 聊天底部菜单列表
    final List ChatMenuList = [
      ChatMenuItem(
        title: '图片',
        imageUrl: 'images/public/picture.png',
        onTap: () {
          controller.sendImageMsg(conversation);
        },
      ),
      ChatMenuItem(
        title: '拍摄',
        imageUrl: 'images/public/skzb.png',
        onTap: () {
          EasyLoading.showToast('拍摄视频');
        },
      ),
      ChatMenuItem(
        title: '收藏',
        imageUrl: 'images/public/xyyx.png',
        onTap: () {
          EasyLoading.showToast('分享收藏');
        },
      ),
      ChatMenuItem(
        title: '文件',
        imageUrl: 'images/public/folder.png',
        onTap: () {
          EasyLoading.showToast('分享文件');
        },
      ),
      ChatMenuItem(
        title: '图文消息',
        imageUrl: 'images/public/tw.png',
        onTap: () {
          EasyLoading.showToast('输入图文消息');
        },
      ),
      ChatMenuItem(
        title: '日程',
        imageUrl: 'images/public/xl.png',
        onTap: () {
          EasyLoading.showToast('发送日程');
        },
      ),
    ];
    return Container(
      height: 200.h,
      color: Color(0xfff3f3f3),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GridView.builder(
        itemCount: ChatMenuList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          ChatMenuItem item = ChatMenuList[index];
          return GestureDetector(
            onTap: item.onTap,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Image.asset(item.imageUrl),
                  ),
                ),
                Text(item.title),
              ],
            ),
          );
        },
      ),
    );
  }

  /// emoji
  Widget _emojiMenu() {
    return SizedBox(
      height: 250,
      child: emoji.EmojiPicker(
        onEmojiSelected: (emoji.Category? category, emoji.Emoji? emoji) {
          controller.hasContent.value = true;
        },
        onBackspacePressed: () {
          controller.msgTf.text.length - 1;
        },
        textEditingController: controller.msgTf,
        config: emoji.Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: emoji.Category.RECENT,
          bgColor: const Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          replaceEmojiOnLimitExceed: false,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
          loadingIndicator: const SizedBox.shrink(),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const emoji.CategoryIcons(),
          buttonMode: emoji.ButtonMode.MATERIAL,
          checkPlatformCompatibility: true,
        ),
      ),
    );
  }
}
