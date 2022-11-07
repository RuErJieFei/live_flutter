import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Get.toNamed(Routes.LOGIN), child: Text('去登录')),
            ElevatedButton(
                onPressed: () {
                  SpUtil.clear();
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: Text('退出登录')),
            Text('用户名： ${SpUtil.getString('username')}'),
            Text('token： ${SpUtil.getString('token')}'),
          ],
        ),
      ),
    );
  }
}
