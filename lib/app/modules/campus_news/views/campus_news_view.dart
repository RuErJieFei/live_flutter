import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/campus_news_controller.dart';

class CampusNewsView extends GetView<CampusNewsController> {
  const CampusNewsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusNewsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CampusNewsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
