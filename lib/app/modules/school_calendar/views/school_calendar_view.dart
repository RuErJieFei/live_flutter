import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/school_calendar_controller.dart';

class SchoolCalendarView extends GetView<SchoolCalendarController> {
  const SchoolCalendarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SchoolCalendarView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SchoolCalendarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
