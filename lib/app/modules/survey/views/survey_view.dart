import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/survey_controller.dart';

class SurveyView extends GetView<SurveyController> {
  const SurveyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SurveyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SurveyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
