import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ask_leave_controller.dart';

class AskLeaveView extends GetView<AskLeaveController> {
  const AskLeaveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AskLeaveView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AskLeaveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
