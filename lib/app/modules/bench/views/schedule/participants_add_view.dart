
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/schedule_controller.dart';

class ParticipantAddView extends GetView<SchedulePageController> {
  const ParticipantAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("新增日程"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.close),),
      ),
      body: Text("添加参与人")
    );

  }
}


