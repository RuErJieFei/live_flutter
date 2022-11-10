import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_page_controller.dart';

class SchedulePageView extends GetView<SchedulePageController> {
  const SchedulePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var cout = 0.obs;
    var selectedDay = DateTime.now().obs;
    var calendarFormat = CalendarFormat.month.obs;
    var _focusedDay = DateTime.now().obs;
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
          IconButton(
              onPressed: () {
                cout++;
              },
              icon: Icon(Icons.more_vert)),
          IconButton(
              onPressed: () {
                controller.increment();
              },
              icon: Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.insert_invitation,
                        color: Colors.blue,
                      )),
                  Text("日程")
                ],
              ),
            ),
            SizedBox(
              width: 120,
            ),
            Container(
              height: 70,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
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
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 350,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Obx(() {
                return TableCalendar(
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
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            width: MediaQuery.of(context).size.width,
            height: size.width*0.12,
            padding: EdgeInsets.all(12),
            child: Obx(() {
              return Text(
                "今天 . ${selectedDay.value.month}月${selectedDay.value.day}日 星期${selectedDay.value.weekday}",
                style: TextStyle(
                  fontSize: 18,
                ),
              );
            }),
          ),
          Container(
            width: size.width,
            height: size.width*0.7,
            child: ListView.builder(
                itemCount: list.length,
                itemExtent: size.width*0.15,
                itemBuilder: (BuildContext c, index) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(list[index]["time"],),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 2,
                          height: size.width*0.12,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(list[index]["name"] ?? "(无主题)"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(list[index]["name2"] ?? ""),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          ),
          // SizedBox(
          //   child: Obx(() {
          //     return Text('${controller.count}');
          //   }),
          // ),
          // SizedBox(
          //   child: Obx(() {
          //     return Text('${cout}');
          //   }),
          // ),
        ],
      ),
    );
  }
}

// Widget myListTile(String lead,{String? title,String? subTitle}) {
//   return Row(
//     children: [
//      Text(lead,),
//       SizedBox(
//         width: 30,
//       ),
//       VerticalDivider(
//         color: Colors.blue,
//         width: 4,
//       ),
//       Column(
//         children: [
//           Text(title ??  "(无主题)"),
//           SizedBox(
//             height: 20,
//           ),
//           Text(subTitle ?? ""),
//         ],
//       )
//     ],
//   );
// }

List list = [
  {"time": "14:00", "name": "zhangsan","name2": "xiao"},
  {"time": "14:00", "name": "zhangsan","name2": "xiao"},
  {"time": "14:00","name2": "xiao"},
  {"time": "14:00", "name": "zhangsan","name2": "xiao"},
  {"time": "14:00", "name": "zhangsan","name2": "xiao"},
];

