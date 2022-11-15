import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wit_niit/app/modules/bench/model/schedule_model.dart';

import '../../../data/helpers.dart';

class SchedulePageController extends GetxController {
  //TODO: Implement BenchController

  final count = 0.obs;
  final unClickColor = Colors.black.obs;
  /// 日程新增页面的开始时间
  var selectedStartDay = DateTime
      .now()
      .obs;
  /// 日程新增页面的开始时间
  var selectedEndDay = DateTime
      .now()
      .obs;

  var isAllDay = false.obs;
  /// 日程列表
  var scheduleList = [].obs;

  /// 添加一条记录到日程列表
  void addSchedule() {
    final Faker faker = Faker(); // 假数据
    final date = Helpers.randomDate();
    ScheduleData data = ScheduleData(
      topic: faker.job.title(),
      address: faker.address.city(),
      time: Jiffy(date).format("HH:ss"),
    );
    scheduleList.add(data);
  }
  @override
  void onInit() {
    super.onInit();
    for (int i = 1; i <= 8; i++) {
      addSchedule();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
