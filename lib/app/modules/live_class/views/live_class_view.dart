import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/live_class_controller.dart';

class LiveClassView extends GetView<LiveClassController> {
  const LiveClassView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveClassView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LiveClassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
