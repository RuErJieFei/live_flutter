import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/room_position_controller.dart';

class RoomPositionView extends GetView {
  const RoomPositionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RoomPositionController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('智慧教室'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 200.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            Text(
              '当前用户组还没有场所，请创建场所',
              style: TextStyle(fontSize: 20),
            ),
            MyButton(
              onTap: () {
                Get.defaultDialog(
                  title: '创建场所',
                  middleText: '请输入场所名',
                  content: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(labelText: '用户组别：'),
                          value: controller.groupList[0].groupName,
                          items: controller.groupList.map((e) {
                            return DropdownMenuItem(
                              child: Text(e.groupName ?? ''),
                              value: e.groupName,
                            );
                          }).toList(),
                          onChanged: (v) {
                            controller.changeGroup(v);
                          },
                        ),
                        TextFormField(
                          controller: controller.positionNameTf,
                          decoration: InputDecoration(
                              hintText: '场所名', labelText: '场所名'),
                        ),
                      ],
                    ),
                  ),
                  confirm: TextButton(
                    onPressed: () {
                      controller.createPosition();
                    },
                    child: Container(
                      child: Text(
                        '确定',
                        textAlign: TextAlign.center,
                      ),
                      width: Get.width / 4,
                    ),
                  ),
                  cancel: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black87,
                    ),
                    child: Container(
                      child: Text(
                        '取消',
                        textAlign: TextAlign.center,
                      ),
                      width: Get.width / 4,
                    ),
                  ),
                );
              },
              title: '新建场所',
            )
          ],
        ),
      ),
    );
  }
}
