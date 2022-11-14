import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timetable_controller.dart';

class TimetableView extends GetView<TimetableController> {
  const TimetableView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimetableView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TimetableView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
