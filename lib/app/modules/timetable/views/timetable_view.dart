import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timetable_controller.dart';

class TimetableView extends GetView<TimetableController> {
   TimetableView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        title: Text(pageTitle()),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_sharp)),
              Text("第6周",style: TextStyle(fontSize: 20),),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("2022-2023学年第1学期")
            ],
          ),
          SizedBox(
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8, childAspectRatio: 1 / 1),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: index == controller.currentWeekIndex.value
                        ? Color(0xf7f7f7)
                        : Colors.white,
                    child: Center(
                      child: index == 0
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("星期",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                          SizedBox(height: 5),
                          Text("日期", style: TextStyle(fontSize: 12)),
                        ],
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(controller.weekList[index - 1],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: index == controller.currentWeekIndex
                                      ? Colors.lightBlue
                                      : Colors.black87)),
                          SizedBox(height: 5),
                          Text(controller.dateList[index - 1],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: index == controller.currentWeekIndex
                                      ? Colors.lightBlue
                                      : Colors.black87)),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                        shrinkWrap: true,
                        // physics:ClampingScrollPhysics(),
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1 / 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // width: 25,
                            // height:s 80,
                              child: Center(
                                child: Text(
                                  (index + 1).toInt().toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff5ff5),
                                // border: Border.all(color: Colors.black12, width: 0.5),
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 0.5),
                                  right: BorderSide(
                                      color: Colors.black12, width: 0.5),
                                ),
                              ));
                        }),
                  ),
                  Expanded(
                    flex: 7,
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 35,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7, childAspectRatio: 1 / 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(color: Colors.black12, width: 0.5),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12,
                                                  width: 0.5),
                                              right: BorderSide(
                                                  color: Colors.black12,
                                                  width: 0.5),
                                            ),
                                          )),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(color: Colors.black12, width: 0.5),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black12,
                                                  width: 0.5),
                                              right: BorderSide(
                                                  color: Colors.black12,
                                                  width: 0.5),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                if (index % 5 == 0 || index % 5 == 1)
                                  Container(
                                    margin: EdgeInsets.all(0.5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: controller.colorList[index % 7],
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.infoList[index % 2],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          _bottomView
        ],
      ),
    );
  }

  @override
  String pageTitle() => "我的课表";

  Widget _topView = SizedBox(
    height: 30,
    child: Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (BuildContext context, int index) {
            return Text("dd");
          }),
    ),
  );
  Widget _centerView = Expanded(
    child: GridView.builder(
        itemCount: 63,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // width: 25,
            // height: 80,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xff5ff5),
                border: Border.all(color: Colors.black12, width: 0.5),
              ));
        }),
  );

  Widget _bottomView = SizedBox(
    height: 30,
    child: Row(
      children: [
        //底部view可自行扩充
      ],
    ),
  );
}

