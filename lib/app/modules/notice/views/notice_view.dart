import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notice_controller.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NoticeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
