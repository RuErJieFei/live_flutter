import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/wit_classroom/views/add_device_view.dart';

import '../controllers/wit_classroom_controller.dart';

class WitClassroomView extends GetView<WitClassroomController> {
  const WitClassroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Obx(() => controller.groupList.length <= 0
    //     ? Scaffold(
    //         appBar: AppBar(
    //           title: const Text('智慧教室'),
    //           centerTitle: true,
    //         ),
    //         body: Center(
    //           child: Column(
    //             children: [
    //               Text('有内容'),
    //             ],
    //           ),
    //         ),
    //       )
    //     : RoomGroupView());

    // if (controller.groupList.length > 0) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('智慧教室'),
    //       centerTitle: true,
    //     ),
    //     body: Center(
    //       child: Column(
    //         children: [
    //           Text('有内容'),
    //         ],
    //       ),
    //     ),
    //   );
    // } else {
    //   return RoomGroupView();
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('智慧教室'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Obx(() {
                  return Container(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: '组别: ',
                      ),
                      value: controller.groupList.length > 0
                          ? controller.groupList.first.groupName
                          : '暂无',
                      items: controller.groupList.map((e) {
                        return DropdownMenuItem(
                          child: Text(
                            e.groupName ?? '',
                          ),
                          value: e.groupName,
                        );
                      }).toList(),
                      onChanged: (v) {
                        // controller.changeGroup(v);
                      },
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none, prefixText: '教室：'),
                      value: controller.roomList.length > 0
                          ? controller.roomList.first.roomName
                          : '暂无',
                      items: controller.roomList.map((e) {
                        return DropdownMenuItem(
                          child: Text(
                            e.roomName ?? '',
                          ),
                          value: e.roomName,
                        );
                      }).toList(),
                      onChanged: (v) {
                        // controller.changeGroup(v);
                      },
                    ),
                  );
                }),
                Obx(() {
                  return controller.deviceList.length <= 0
                      ? Container(
                          height: Get.height / 2,
                          alignment: Alignment.center,
                          child: Text(
                            '该组别该教室下暂无设备',
                            style: BaseStyle.grayContentStyle,
                          ),
                        )
                      : GridView.custom(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              Widget deviceIcon;
                              return GestureDetector(
                                onTap: () => {},
                                child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      spacing: 20.h,
                                      children: [
                                        Text(
                                          controller.deviceList[index]
                                                  .deviceName ??
                                              '',
                                          style:
                                              BaseStyle.grayBoldBigContentStyle,
                                        ),
                                        Icon(
                                          Icons.lightbulb_rounded,
                                          color: Colors.yellow.shade600,
                                          size: 40.w,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: controller.deviceList.length,
                          ));
                }),
                // Obx(() {
                //   return Material(
                //     color: Colors.red,
                //     child: TabBar(
                //       controller: controller.tabController,
                //       labelColor: Colors.black87,
                //       indicatorSize: TabBarIndicatorSize.label,
                //       tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
                //     ),
                //   );
                // }),
                // Expanded(
                //   flex: 1,
                //   child:
                //       TabBarView(controller: controller.tabController, children: [
                //     // buildEditView(),
                //     // buildSettingView(context),
                //     Text('1'),
                //     // Text('2'),
                //   ]),
                // ),
              ],
            ),
          ),
          Positioned(
              width: Get.width,
              bottom: 20.h,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyButton(
                    onTap: () => Get.to(() => AddDeviceView()), title: '添加设备'),
              )),
        ],
      ),
    );
  }
}
