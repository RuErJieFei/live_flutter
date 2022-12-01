import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/room_group_controller.dart';
import 'package:wit_niit/app/modules/wit_classroom/views/room_position_view.dart';

class RoomGroupView extends GetView<RoomGroupController> {
  const RoomGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RoomGroupController>();
    return Obx(() {
      return controller.groupList.length <= 0
          ? Scaffold(
              appBar: AppBar(
                title: const Text('智慧教室'),
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.only(top: 200.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Text(
                      '你还没有用户组，请创建/被邀进入用户组',
                      style: TextStyle(fontSize: 20),
                    ),
                    MyButton(
                      onTap: () {
                        Get.defaultDialog(
                          title: '创建用户组',
                          middleText: '请输入用户组名',
                          content: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: controller.groupNameTf,
                              decoration: InputDecoration(
                                  hintText: '用户组名', labelText: '用户组名'),
                            ),
                          ),
                          confirm: TextButton(
                            onPressed: () {
                              controller.createGroup();
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
                      title: '新建用户组',
                    )
                  ],
                ),
              ),
            )
          : RoomPositionView();
    });
  }
}
