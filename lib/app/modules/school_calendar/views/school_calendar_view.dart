
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import '../controllers/school_calendar_controller.dart';


class SchoolCalendarView extends GetView<SchoolCalendarController> {
  const SchoolCalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _focusedDay = DateTime.now().obs;
    final _initialCalendarDate = DateTime(2000).obs;
    final _lastCalendarDate = DateTime(2050).obs;
    var selectedCalendarDate = DateTime
        .now()
        .obs;
    final size = MediaQuery
        .of(context)
        .size;

    var selectedAfter = "2018-2019年第一学期(共21周)".obs;
    //点击选择学期
    void _didClickSelectedSemester() {
      showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return Obx(() {
              return Container(
                height: 250,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("取消"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            selectedAfter.value = controller.selectedValue.value;
                          },
                          child: Text("完成"),
                        ),
                      ],
                    ),
                    Expanded(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        child: _buildGenderPicker(),
                      ),
                    ),
                  ],
                ),
              );
            });
          });
    }
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close),),
        title: const Text('校历'),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 120.h,
                        decoration: BoxDecoration(
                            color: Config.primaryColor
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _didClickSelectedSemester();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(selectedAfter.value, style: TextStyle(
                                      fontSize: 17, color: Colors.white),),

                                      Icon(Icons.arrow_drop_down,
                                          color: Colors.white)
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(onPressed: () {
                                      _focusedDay.value = _focusedDay.value.add(Duration(days: -30));
                                    },
                                        icon: Icon(
                                            Icons.arrow_circle_left_sharp,
                                            size: 25, color: Colors.white)),
                                    Text("${formatDate(_focusedDay.value,[yyyy,"年",mm,"月"])}", style: TextStyle(
                                        fontSize: 17, color: Colors.white)),
                                    IconButton(onPressed: () {
                                      _focusedDay.value = _focusedDay.value.add(Duration(days: 30));
                                    },
                                        icon: Icon(
                                            Icons.arrow_circle_right_sharp,
                                            size: 25, color: Colors.white))
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.book_outlined,
                                          color: Colors.white),
                                      Text("校历总览", style: TextStyle(
                                          fontSize: 17, color: Colors.white))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 80.w, child: Row(children: [
                            Icon(Icons.rectangle, color: Colors.orange,),
                            Text("教学周")
                          ],)),
                          SizedBox(
                              width: 80.w, child: Row(children: [
                            Icon(Icons.rectangle, color: Colors.red,),
                            Text("节假日")
                          ],)),
                          SizedBox(
                              width: 80.w, child: Row(children: [
                            Icon(Icons.rectangle, color: Colors.green,),
                            Text("考试周")
                          ],)),
                          SizedBox(
                              width: 80.w, child: Row(children: [
                            Icon(Icons.circle, color: Colors.blue,),
                            Text("事件")
                          ],)),
                        ],
                      ),
                      TableCalendar(
                        focusedDay: _focusedDay.value,
                        // today's date
                        firstDay: _initialCalendarDate.value,
                        // earliest possible date
                        lastDay: _lastCalendarDate.value,
                        // latest allowed date
                        calendarFormat: CalendarFormat.month,
                        // default view when displayed
                        // default is Saturday & Sunday but can be set to any day.
                        // instead of day number can be mentioned as well.
                        weekendDays: const [DateTime.sunday, 6],
                        // default is Sunday but can be changed according to locale
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        // height between the day row and 1st date row, default is 16.0
                        daysOfWeekHeight: 40.0,
                        // height between the date rows, default is 52.0
                        rowHeight: 60.0,
                        locale: "Zh",
                        // this property needs to be added if we want to show events
                        // eventLoader: _listOfDayEvents,
                        // Calendar Header Styling
                        headerVisible: false,
                        calendarStyle: CalendarStyle(
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedCalendarDate.value, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                            selectedCalendarDate.value = selectedDay;
                            _focusedDay.value = focusedDay;
                        },
                        onPageChanged: (focusedDay) {
                         _focusedDay.value = focusedDay;
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
        );
      }),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          backgroundColor: Config.mainColor, onPressed: () {
          // Get.to(() => CustomTableCalendar());
          _focusedDay.value = DateTime.now();
        },
          child: Text("今", style: TextStyle(
              fontSize: 25
          ),),
        ),
      ),
    );
  }

  Widget _buildGenderPicker() {
    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (value) {
        print(value);
       controller.selectedValue.value = controller.semesterList[value];
      },
      children: controller.semesterList.map((data) {
        return Text(data);
      }).toList(),
    );
  }


}
