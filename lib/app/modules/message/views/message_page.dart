import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/message/bindings/chat_binding.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/model/story_data.dart';
import 'package:wit_niit/app/modules/message/widget/conversation_tile.dart';

import 'chat_view.dart';

class MessagesPage extends GetView<MessageController> {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _Stories()),
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
    Conversation conv = controller.conversationList[index];
    UserModel? myInfo = SpUtil.getObj("user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    String? title = conv.name?.replaceAll("${myInfo?.name}", "");
    return ConversationTitle(
      conversation: conv,
      callback: () {
        controller.currentConv = conv;
        Get.to(
          () => ChatView(
            conversation: conv,
            titleName: '$title',
          ),
          binding: ChatBinding(),
        )?.then((value) {
          controller.updateConversationList();
        });
      },
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
                            }).catchError((e) {
                              // 若下线会导致失败
                              LogUtil.v(e);
                              EasyLoading.showError('状态异常，请重启App');
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
