import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wit_classroom_controller.dart';

class WitClassroomView extends GetView<WitClassroomController> {
  const WitClassroomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WitClassroomView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'WitClassroomView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
