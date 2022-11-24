import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/message/widget/date_bar.dart';
import '../controllers/notice_controller.dart';
import '../widget/bubble.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知公告'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0.w),
        reverse: true,
        itemCount: 1,
        itemBuilder: (_, int index) => Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.noticeList,
          );
        }),
      ),
    );
  }
}
