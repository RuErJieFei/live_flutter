import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/campus_mail_controller.dart';

class CampusMailView extends GetView<CampusMailController> {
  const CampusMailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusMailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CampusMailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
