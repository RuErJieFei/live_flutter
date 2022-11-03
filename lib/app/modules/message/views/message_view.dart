import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';

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
        child: Text(
          'MessageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
