import 'package:date_format/date_format.dart';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/participants_add_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_add_view.dart';
import '../../../../../main.dart';
import '../../controllers/schedule_controller.dart';
import '../../model/schedule_model_release.dart';

class ScheduleEditView extends GetView<SchedulePageController> {
  // const ScheduleEditView({Key? key}) : super(key: key);
  final int index;

  ScheduleEditView(this.index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var scheduleId = controller.scheduleList[index].scheduleId;
    var thisDate = formatDate(controller.selectedEditStartDay.value,
        [yyyy, "-", mm, "-", dd, " ", hh, ":", nn, ":", ss]);
    updateScheduleInfo() async {
      print(thisDate);
      var data = {
        "scheduleId": scheduleId,
        "organizationId": SpUtil.getString("userId"),
        "topic": controller.topicEditController.value.text,
        // "participant": [1,2,3,4,5,7],
        "startTime": thisDate,
        // "duration": 60,
        "isAllday": false,
        "address": controller.addressEditController.value.text,
        // "attachment": ["djasjd","ksjkdk"],
        "description": controller.descriptionEditController.value.text,
        "alertTime": 15,
        "isRepeat": false,
        "isActive": false,
        "calender": "选择日历"
      };
      var resp = await request.post("/schedule/updateScheduleById", data: data);
      // var resp = await Dio().post("http://121.40.208.79:10000/api/schedule/addSchedule",data: data);
      if (resp == 1) {
        controller.topicEditController.value.clear();
        controller.addressEditController.value.clear();
        controller.descriptionEditController.value.clear();
        controller.scheduleList.value = await controller.getScheduleByDate();
        controller.scheduleList.value = controller.scheduleList.map((element) => Data.fromJson(element)).toList();
        EasyLoading.showToast("修改成功");
        Get.back();
      } else {
        EasyLoading.showToast("修改失败");
      }

    }

    return Scaffold(
      /// 输入框超出解决
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("修改日程信息"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(flex: 1, child: _Topic(context)),
              SykDivider(context, 8),
              Expanded(flex: 1, child: _Participants(context)),
              SykDivider(context, 8),
              Expanded(flex: 3, child: _TimeComponent(context)),
              SykDivider(context, 8),
              Expanded(flex: 1, child: _Address(context)),
              SykDivider(context, 8),
              Expanded(flex: 1, child: _Attachment(context)),
              SykDivider(context, 8),
              Expanded(flex: 1, child: _Description(context)),
              SykDivider(context, 8),
              Expanded(flex: 5, child: _MoreComponent(context)),
              ElevatedButton(
                  onPressed: () {
                    updateScheduleInfo();
                  },
                  child: Text("保存"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement controller
  SchedulePageController get controller => super.controller;

  Widget _Topic(BuildContext context) {
    // controller.topicEditController.value.text =
    //     controller.scheduleList[index].topic;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: controller.topicEditController.value,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "日程、活动主题",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _Participants(BuildContext context) {
    // controller.topicEditController.value.text = controller.scheduleList[index].topic;
    return Container(
      padding: EdgeInsets.only(
        left: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: Row(children: [
        Text(
          "添加参与人",
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              Get.to(() => ParticipantAddView());
            },
            icon: Icon(
              Icons.control_point,
              color: Colors.grey,
            ))
      ]),
    );
  }

  Widget _TimeComponent(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: MediaQuery.of(context).size.width,
        height: 150.h,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "开始",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                GestureDetector(
                  child: controller.isAllDayEdit.value
                      ? Text("${formatDate(DateTime.now(), [
                              mm,
                              "月",
                              dd,
                              "日 ",
                            ])}")
                      : Text(
                          "${formatDate(controller.selectedEditStartDay.value, [
                              mm,
                              "月",
                              dd,
                              "日     ",
                              HH,
                              ":",
                              nn
                            ])}"),
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        maxTime: DateTime(2050, 12, 1),
                        minTime: DateTime(2020, 1, 1),
                        currentTime: DateTime.now(),
                        locale: LocaleType.zh, onChanged: (date) {
                      if (controller.isAllDayEdit.value == true) {
                        controller.selectedEditStartDay.value = DateTime.now();
                      } else {
                        controller.selectedEditStartDay.value = date;
                      }
                      print('change ${controller.selectedEditStartDay.value}');
                    });
                  },
                ),
              ],
            ),
            SykDivider(context, 2),
            Row(
              children: [
                Text(
                  "结束",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                GestureDetector(
                  child: controller.isAllDayEdit.value
                      ? Text("${formatDate(DateTime.now(), [
                              mm,
                              "月",
                              dd,
                              "日 ",
                            ])}")
                      : Text(
                          "${formatDate(controller.selectedEditEndDay.value, [
                              mm,
                              "月",
                              dd,
                              "日     ",
                              HH,
                              ":",
                              nn
                            ])}"),
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        maxTime: DateTime(2050, 12, 1),
                        minTime: DateTime(2020, 1, 1),
                        currentTime: DateTime.now(),
                        locale: LocaleType.zh, onChanged: (date) {
                      if (controller.isAllDayEdit.value == true) {
                        controller.selectedEditEndDay.value = DateTime.now();
                      } else {
                        controller.selectedEditEndDay.value = date;
                      }
                      print('change ${controller.selectedEditEndDay.value}');
                    });
                  },
                ),
              ],
            ),
            SykDivider(context, 2),
            Row(
              children: [
                Text(
                  "全天",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                Switch(
                  value: controller.isAllDayEdit.value,
                  onChanged: (val) {
                    controller.isAllDayEdit.value = val;
                    print(controller.isAllDayEdit.value);
                  },
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _Address(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: controller.addressEditController.value,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "请输入地址",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _Attachment(BuildContext context) {
    TextEditingController addressController = TextEditingController();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: addressController,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "添加附件...",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _Description(BuildContext context) {
    // controller.descriptionEditController.value.text =
    //     controller.scheduleList[index].description;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: controller.descriptionEditController.value,
        maxLines: 3,
        //校验用户
        validator: (value) {},
        //当 Form 表单调用保存方法 Save时回调的函数。
        onSaved: (value) {},
        // 当用户确定已经完成编辑时触发
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "描述",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _MoreComponent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 300.h,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "提醒",
                style: TextStyle(fontSize: 20.sp),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios, size: 15))
            ],
          ),
          SykDivider(context, 2),
          Row(
            children: [
              Text(
                "重复",
                style: TextStyle(fontSize: 20.sp),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios, size: 15))
            ],
          ),
          SykDivider(context, 2),
          Row(
            children: [
              Text(
                "主动加入",
                style: TextStyle(fontSize: 20.sp),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios, size: 15))
            ],
          ),
          SykDivider(context, 2),
          Row(
            children: [
              Text(
                "日历",
                style: TextStyle(fontSize: 20.sp),
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
