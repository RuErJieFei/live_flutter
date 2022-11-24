import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimetableController extends GetxController {
  //TODO: Implement TimetableController

  final count = 0.obs;
  var weekList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'].obs;
  var colorList = [
    Colors.red,
    Colors.lightBlueAccent,
    Colors.grey,
    Colors.cyan,
    Colors.amber,
    Colors.deepPurpleAccent,
    Colors.purpleAccent
  ].obs;
  var infoList = ["高等数学-周某某教授@综合楼201", "大学英语-王某某讲师@行政楼501"].obs;
  var dateList = [].obs;
  var currentWeekIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    var monday = 1;
    var mondayTime = DateTime.now();

    //获取本周星期一是几号
    while (mondayTime.weekday != monday) {
      mondayTime = mondayTime.subtract(new Duration(days: 1));
    }

    mondayTime.year; //2020 年
    mondayTime.month; //6(这里和js中的月份有区别，js中是从0开始，dart则从1开始，我们无需再进行加一处理) 月
    mondayTime.day; //6 日
    // nowTime.hour ;//6 时
    // nowTime.minute ;//6 分
    // nowTime.second ;//6 秒
    for (int i = 0; i < 7; i++) {
      dateList.add(
          mondayTime.month.toString() + "/" + (mondayTime.day + i).toString());
      if ((mondayTime.day + i) == DateTime.now().day) {
          currentWeekIndex.value = i + 1;
      }
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
