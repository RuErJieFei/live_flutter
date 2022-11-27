import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/ask_leave/bindings/ask_leave_binding.dart';
import 'package:wit_niit/app/modules/ask_leave/views/ask_leave_student_view.dart';

import '../controllers/ask_leave_controller.dart';

class AskLeaveView extends GetView<AskLeaveController> {
  const AskLeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('请假'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (_, int index) {
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "事假（不离宁，不占课）",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2022-10-01 12:15 至 2022-10-01 21:10",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        "共1天",
                        style: TextStyle(fontSize: 14.sp),
                      )
                    ],
                  ),
                  trailing: Container(
                    width: 0.13.sw,
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 6,
                          color: Colors.green,
                        ),
                        Text("已销假"),
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AskLeaveStudentView(),binding: AskLeaveBinding());
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Config.primaryColor,
      ),
    );
  }
}
