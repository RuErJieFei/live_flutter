import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/index/controllers/index_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var indexC = Get.find<IndexController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('消息'),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              indexC.open();
            },
          );
        }),
        actions: [
          Icon(Icons.add_circle_outline),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
