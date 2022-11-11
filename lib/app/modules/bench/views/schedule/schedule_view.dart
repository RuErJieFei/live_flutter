import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_will_do.dart';

class SchedulePageView extends GetView<SchedulePageController> {
  const SchedulePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;

    var selectedDay = DateTime
        .now()
        .obs;

    var _focusedDay = DateTime
        .now()
        .obs;
    Get.put(SchedulePageController());
    initializeDateFormatting();
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text('${_focusedDay.value.year}年${_focusedDay.value.month}月');
        }),
        // title: Text("日程"),

        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar:
        BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80.h,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(()=>SchedulePageView());
                        },
                        icon: Icon(
                          Icons.insert_invitation,
                          color: Colors.blue,
                        )),
                    Text("日程",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              Container(
                height: 80.h,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(()=>ScheduleWillDoView());
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
              width: size.width.w,
              height: size.height * 0.4.h,
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
                    onDaySelected: (selectedDay1, focusedDay1) {
                      selectedDay.value = selectedDay1;
                      _focusedDay.value =
                          focusedDay1; // update `_focusedDay` here as well
                    },
                    onPageChanged: (focusedDay2) {
                      _focusedDay.value = focusedDay2;
                    },
                  );
                }),
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width
                  .w,
              height: size.width * 0.18.h,
              padding: EdgeInsets.all(12),
              child: Obx(() {
                return Text(
                  "今天 . ${selectedDay.value.month}月${selectedDay.value
                      .day}日 星期${selectedDay.value.weekday}",
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
                    itemExtent: size.width * 0.15.w,
                    itemBuilder: (BuildContext c, index) {
                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.scheduleList[index].time,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Container(
                              width: 2.h,
                              height: size.width * 0.12.h,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(controller.scheduleList[index].topic ??
                                    "(无主题)"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(controller.scheduleList[index].address ??
                                    ""),
                              ],
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
