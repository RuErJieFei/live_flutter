import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_add_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_edit_view.dart';
import 'package:wit_niit/main.dart';
import '../../../../data/theme_data.dart';
import '../../model/schedule_model_release.dart';

class ScheduleDetailView extends GetView<SchedulePageController> {
  final int index;
  const ScheduleDetailView(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text("日程详情"),
          actions: [_popupMenu()],
        ),
        bottomNavigationBar:
        BottomAppBar(
          child: Row(
            children: [
            Row(
              children: [
                Icon(Icons.radio_button_off),
                Text("接受")
              ],
            ),
              SizedBox(
                width: 50.w,
              ),
              Row(
                children: [
                  Icon(Icons.radio_button_off),
                  Text("待定")
                ],
              ),
              SizedBox(
                width: 50.w,
              ),
              Row(
                children: [
                  Icon(Icons.radio_button_off),
                  Text("拒绝")
                ],
              ),
              SizedBox(
                width: 50.w,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.send,size: 20,))
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                width: MediaQuery.of(context).size.width,
                height: 120.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.scheduleList[index].topic}",
                      style: TextStyle(fontSize: 25.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("${controller.scheduleList[index].startTime}",
                        style: TextStyle(fontSize: 22.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Text("地点：", style: TextStyle(fontSize: 18.sp)),
                  Text("${controller.scheduleList[index].address}",
                  style: TextStyle(fontSize: 18.sp)),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Icon(Icons.chat),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                EasyLoading.showToast("进入聊天");
                              },
                              child: Text("进入聊天",
                                  style: TextStyle(fontSize: 20.sp)))
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Icon(Icons.book),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                EasyLoading.showToast("进入聊天");
                              },
                              child: Text("会议纪要",
                                  style: TextStyle(fontSize: 20.sp)))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SykDivider(context, 8),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: size.width,
                height: 130.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "组织人",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "http://uplaod-189989.oss-cn-hangzhou.aliyuncs.com/avatar.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        // Text("${controller.scheduleList[index].organizationId}"),
                        Text("接口选择"),
                        SizedBox(
                          width: 70.w,
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                      ],
                    ),
                    SykDivider(context, 2),
                    Row(
                      children: [
                        Text(
                          "参与人",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "http://uplaod-189989.oss-cn-hangzhou.aliyuncs.com/avatar.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        // Text("${controller.scheduleList[index].participantId}"),
                        Text("接口选择"),
                        SizedBox(
                          width: 70.w,
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios,size: 15,))
                      ],
                    ),
                  ],
                ),
              ),
              SykDivider(context, 8),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: size.width,
                height:100.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("描述" ,style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 60.w,),
                        Text("${controller.scheduleList[index].description}", style: TextStyle(fontSize: 18.sp)),
                      ],
                    ),
                    SizedBox(height: 8.h,),
                   SykDivider(context, 2),
                    Row(
                      children: [
                        Text("附件", style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 60.w,),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "http://uplaod-189989.oss-cn-hangzhou.aliyuncs.com/avatar.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SykDivider(context, 8),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: size.width,
                height:100.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("提醒" ,style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 60.w,),
                        Text("${controller.scheduleList[index].alertTime}分钟前", style: TextStyle(fontSize: 18.sp)),
                      ],
                    ),

                    SykDivider(context, 2),
                    Row(
                      children: [
                        Text("日历", style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 60.w,),
                        Text("农历", style: TextStyle(fontSize: 18.sp)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
  Widget _popupMenu() {
    var scheduleId = controller.scheduleList[index].scheduleId;
    deleteById() async {
      var res =await request.post("/schedule/deleteScheduleById",params: {"id":scheduleId});
      if(res == 1){
        Get.back();
        EasyLoading.showToast("删除成功");
        controller.scheduleList.value = await controller.getScheduleByDate();
        controller.scheduleList.value = controller.scheduleList.map((element) => Data.fromJson(element)).toList();
      }else{
        EasyLoading.showToast("删除失败");
      }
      print(res);
    }
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: PopupMenuButton(
        position: PopupMenuPosition.under,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(20),
          ),
        ),
        onSelected: (v) {
          if (v == '编辑') {
            controller.descriptionEditController.value.text = controller.scheduleList[index].description;
            controller.addressEditController.value.text = controller.scheduleList[index].address;
            controller.topicEditController.value.text = controller.scheduleList[index].topic;
            Get.to(()=> ScheduleEditView(index));
            EasyLoading.showToast('编辑');
          } else if (v == '删除') {
            deleteById();
            print(controller.scheduleList[index].scheduleId);
            // EasyLoading.showToast('删除');
          }
        },
        itemBuilder: (context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: '编辑',
              child: Row(
                children: [
                  Text('编辑',
                      style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: '删除',
              child: Row(
                children: [
                  Text('删除',
                      style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
                ],
              ),
            ),
          ];
        },
        child: Icon(Icons.more_vert),
      ),
    );
  }
}


