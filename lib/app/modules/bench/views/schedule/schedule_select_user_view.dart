import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';

class ScheduleSelectUserView extends GetView<SchedulePageController> {
  const ScheduleSelectUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("选择用户页"),

      ),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            controller.userList.add(Random(10));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
