import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/modules/message/bindings/chat_binding.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/model/story_data.dart';
import 'package:wit_niit/app/modules/message/widget/group_avatar.dart';

import 'chat_view.dart';

class MessagesPage extends GetView<MessageController> {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _Stories()),
        SliverToBoxAdapter(
            child: ListTile(
          title: Text('1234'),
        )),
        Obx(() {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              _delegate,
              childCount: controller.conversationList.length,
            ),
          );
        })
      ],
    );
  }

  /// 会话列表
  Widget _delegate(BuildContext context, int index) {
    return _ConversationTitle(
      conversation: controller.conversationList[index],
    );
  }
}

class _ConversationTitle extends GetView<MessageController> {
  const _ConversationTitle({Key? key, required this.conversation}) : super(key: key);
  final Conversation conversation; // 会话

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
      onTap: () {
        controller.currentConv = conversation;
        Get.to(
          () => ChatView(
            conversation: conversation,
            titleName: '${contact.value.name}',
          ),
          binding: ChatBinding(),
        )?.then((value) {
          controller.updateConversationList();
        });
      },
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

/// 顶部好友列表
class _Stories extends GetView<MessageController> {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 4.h, bottom: 7.h),
              child: Text(
                '联系人',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.sp,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.contactsMap.length,
                  itemBuilder: (BuildContext context, int index) {
                    ContactModel contact = controller.contactsMap.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 60.w,
                        child: InkWell(
                          /// 点击与他发起聊天
                          onTap: () {
                            controller
                                .createConversation('${contact.id}', '${contact.name}')
                                .then((conv) {
                              controller.currentConv = conv;
                              Get.to(
                                () => ChatView(titleName: '${contact.name}', conversation: conv),
                                binding: ChatBinding(),
                              )?.then((value) {
                                /// 更新会话列表
                                controller.updateConversationList();
                              });
                            }).catchError((_) {
                              // 若下线会导致失败
                              EasyLoading.showError('创建会话失败');
                              controller.onReady(); // 重新登录LC
                            });
                          },
                          child: _StoryCard(
                            storyData: StoryData(
                              name: contact.name ?? 'null',
                              url: contact.photo!,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key? key, required this.storyData}) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.r)),
          ),
          height: 50.r,
          clipBehavior: Clip.antiAlias,
          child: BGPositionImage.positionImage(storyData.url),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
