import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_will_do_add_view.dart';

import '../bench_view.dart';

class ScheduleWillDoView extends GetView<SchedulePageController> {
  const ScheduleWillDoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    Get.put(SchedulePageController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Get.to(()=>BenchView()); }, icon: Icon(Icons.arrow_back),),
        title: Text("待办"),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          IconButton(onPressed: () {
            Get.to(() => ScheduleWillDoAddView());
          }, icon: Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar:
      BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.h,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(()=>SchedulePageView());
                        },
                        icon: Icon(
                          Icons.insert_invitation,

                        )),
                    Text("日程")
                  ],
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              Container(
                height: 100.h,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(()=>ScheduleWillDoView());
                      },
                      icon: Icon(
                        Icons.check_circle_outline,
                          color: Colors.blue
                      ),
                    ),
                    Text("待办",style: TextStyle(color: Colors.blue),)
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
              child: Text("daiban"),
            ),
          ],
        ),
      ),
    );
  }
}

