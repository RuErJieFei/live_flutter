import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_page_view.dart';

import '../controllers/bench_controller.dart';
import 'enter_school_view.dart';

class BenchView extends GetView<BenchController> {
  const BenchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BenchView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            MyButton(
              onTap: () {
                Get.to(EnterSchoolView());
              },
              title: '去智慧入校',
            ),
            SizedBox(height: 10,),
            MyButton(
              onTap: () {
                Get.to(SchedulePageView());
              },
              title: '日程',
            ),
          ],
        ),
      ),
    );
  }
}
