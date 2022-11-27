
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/schedule_controller.dart';

class ParticipantAddView extends GetView<SchedulePageController> {
  const ParticipantAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // void _sendMessage() {
    //   controller.channel.sink.add("nihao");
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("新增日程"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        },icon: Icon(Icons.close),),
      ),
      body:
      // StreamBuilder(
      //     stream: controller.channel.stream,
      //     builder: (context, snapshot) {
      //       print(snapshot.hasData);
      //       return Text(snapshot.hasData ? '${snapshot.data}' : '');
      //     },

      // ),
      Text("djskj"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _sendMessage();
          print("点击");
        },
      ),
    );

  }
}


