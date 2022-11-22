import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_add_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_detail_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_search_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_will_do.dart';
import '../../../../../main.dart';
import '../../../../data/theme_data.dart';
import '../../model/schedule_model_release.dart';

class SchedulePageView extends GetView<SchedulePageController> {
  const SchedulePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var selectedDay = DateTime.now().obs;
    var _focusedDay = DateTime.now().obs;
    Get.put(SchedulePageController());
    initializeDateFormatting();

    Future<List> getScheduleByDate() async{
      String? userId = SpUtil.getString("userId");
      print(userId);
       var day =  formatDate(selectedDay.value,[yyyy,"/",mm,"/",dd,]);
      print(day);
      Map<String,dynamic> params = {"date":day,"organizationId":userId};
      // var res = await Dio().get("http://121.40.208.79:10000/api/schedule/searchScheduleByUserIdAndDate",queryParameters: params);
      var res = await request.get("/schedule/searchScheduleByUserIdAndDate",params: params);
      print(res);
      // var result = ScheduleModel.fromJson(json.decode(res.toString()));
      // print(result.data);
      return res;
    }
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text('${_focusedDay.value.year}年${_focusedDay.value.month}月');
        }),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: search());
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: () async {
            // getScheduleByDate();
            controller.scheduleList.value = await getScheduleByDate();
            controller.scheduleList.value= controller.scheduleList.map((element) => Data.fromJson(element)).toList();
          print(controller.scheduleList[0].scheduleId);
          }, icon: Icon(Icons.more_vert)),
          _popupMenu(context)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 85.h,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => SchedulePageView());
                      },
                      icon: Icon(
                        Icons.insert_invitation,
                        color: Colors.blue,
                      )),
                  Text(
                    "日程",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 120.w,
            ),
            Container(
              height: 85.h,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => ScheduleWillDoView());
                    },
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                  ),
                  Text("待办")
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 320.h,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Obx(() {
                  return TableCalendar(
                    rowHeight: 40,
                    availableGestures: AvailableGestures.all,
                    sixWeekMonthsEnforced: true,
                    headerVisible: false,
                    locale: 'zh_CN',
                    focusedDay: _focusedDay.value,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    calendarStyle: CalendarStyle(
                        holidayTextStyle: TextStyle(color: Colors.red),
                        holidayDecoration: BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        // Use `CalendarStyle` to customize the UI
                        outsideDaysVisible: true,
                        markerMargin: EdgeInsets.only(top: 8),
                        cellMargin:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                        todayDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        // markerSizeScale: 5,
                        markerDecoration: BoxDecoration(
                            color: Colors.cyan, shape: BoxShape.circle),
                        canMarkersOverflow: true),
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDay.value, day);
                    },
                    onDaySelected: (selectedDay1, focusedDay1) async {
                      selectedDay.value = selectedDay1;
                      _focusedDay.value =
                          focusedDay1;
                      controller.scheduleList.value = await getScheduleByDate();
                      controller.scheduleList.value= controller.scheduleList.map((element) => Data.fromJson(element)).toList();
                      print(controller.scheduleList[0].scheduleId);// update `_focusedDay` here as well
                    },
                    onPageChanged: (focusedDay2) {
                      _focusedDay.value = focusedDay2;
                    },
                  );
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width.w,
              height: size.width * 0.18.h,
              padding: EdgeInsets.all(12),
              child: Obx(() {
                return Text(
                  "今天 . ${selectedDay.value.month}月${selectedDay.value.day}日 星期${selectedDay.value.weekday}",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                );
              }),
            ),
            Obx(() {
              return Container(
                width: size.width.w,
                height: size.width * 0.7.h,
                child: ListView.builder(
                    itemCount: controller.scheduleList.length,
                    itemExtent: size.width * 0.2.w,
                    itemBuilder: (BuildContext c, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ScheduleDetailView(index));
                        },
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50.w,
                              child: Text(
                                controller.scheduleList[index].startTime,
                              ),
                            ),
                            Container(
                              width: 2.h,
                              height: size.width * 0.15.h,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              height: 80.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.scheduleList[index].topic??
                                      "(无主题)"),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(controller.scheduleList[index].address ??
                                      ""),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget _popupMenu(BuildContext context) {
  return PopupMenuButton(
    offset: Offset(0, 50),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(20),
      ),
    ),
    onSelected: (v) {
      if (v == '预定会议') {
        EasyLoading.showToast('预定会议');
      } else if (v == '新建日程') {
        Get.to(() => ScheduleAddView());
      }
    },
    itemBuilder: (context) {
      return <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: '预定会议',
          child: Wrap(
            spacing: 10,
            children: [
              Icon(Icons.check_box, color: Config.mainColor),
              Text('预定会议',
                  style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: '新建日程',
          child: Wrap(
            spacing: 10,
            children: [
              Icon(Icons.assessment, color: Config.mainColor),
              Text('新建日程',
                  style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
            ],
          ),
        ),
      ];
    },
    child: Icon(Icons.add),
  );
}
