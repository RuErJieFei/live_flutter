import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/helpers.dart';
import 'package:wit_niit/app/modules/message/bindings/chat_binding.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/message_model.dart';
import 'package:wit_niit/app/modules/message/model/story_data.dart';
import 'package:wit_niit/app/modules/message/widget/avatar.dart';

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
              childCount: controller.messageList.length,
            ),
          );
        })
      ],
    );
  }

  /// 消息列表
  Widget _delegate(BuildContext context, int index) {
    return _MessageTitle(
      messageData: controller.messageList[index],
    );
  }
}

class _MessageTitle extends GetView<MessageController> {
  const _MessageTitle({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatView(messageData: messageData), binding: ChatBinding());
      },
      child: Container(
        height: 100.h,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          // color: AppColors.textFaded,
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
                      messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        // color: AppColors.textFaded,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(fontSize: 10, color: Colors.white),
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
                '最近聊天',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.sp,
                  // color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  final faker = Faker();
                  final avatar = Helpers.randomPictureUrl();
                  final name = faker.person.name();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60.w,
                      child: InkWell(
                        /// 点击与他发起聊天
                        onTap: () {
                          Get.to(
                            () => ChatView(
                              messageData: MessageData(
                                senderName: name,
                                message: '',
                                messageDate: Helpers.randomDate(),
                                dateMessage: '',
                                profilePicture: avatar,
                              ),
                            ),
                          );
                          // controller.addMessage();
                        },
                        child: _StoryCard(
                          storyData: StoryData(
                            name: name,
                            url: avatar,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
        Avatar.medium(url: storyData.url),
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
