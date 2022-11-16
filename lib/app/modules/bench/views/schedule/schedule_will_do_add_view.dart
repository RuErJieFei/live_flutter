import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_add_view.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_select_user_view.dart';

class ScheduleWillDoAddView extends GetView<SchedulePageController> {
  const ScheduleWillDoAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    var selectedDate = DateTime
        .now()
        .obs;
    // var willController = TextEditingController().obs;
   var  isSelectedDate = true.obs;
    // var  isSelectedPersons = false.obs;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
          // isSelectedDate.value = true;
        }, icon: Icon(Icons.close),),
        title: Text("新增待办"),
        centerTitle: true,
      ),
      body: Obx(() {
        return Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              TextFormField(
                // autofocus: true,
                maxLines: 5,
                // controller: willController.value,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  hintText: "写下你的待办...",
                  contentPadding: EdgeInsets.only(left: 20),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                // onChanged: (val) {
                //   willController.value.text = val;
                //   print(val);
                // },
                // onSaved: (val) {
                //   willController.value.text = val!;
                // },
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: size.width,
                height: 160.h,
                child: Column(
                  children: [
                    SykDivider(context, 2),
                    Row(children: [

                      Text('参与人', style: TextStyle(
                        fontSize: 20.sp,
                      ),),
                      Spacer(),
                      controller.userList.length == 0? Text('请选择', style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey
                      )) : Text('${controller.userList.length}人', style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey
                      )),
                      IconButton(onPressed: () {
                        Get.to(() => ScheduleSelectUserView());
                      }, icon: Icon(Icons.arrow_forward_ios, size: 15.sp,))
                    ],),
                    SykDivider(context, 2),
                    Row(children: [
                      Text('提醒我', style: TextStyle(
                        fontSize: 20.sp,
                      ),),
                      Spacer(),
                      isSelectedDate.value ? Text('无提醒', style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey
                      )) : Text('${formatDate(selectedDate.value, [
                        mm,
                        "-",
                        dd,
                        "  ",
                        HH,
                        ":",
                        nn
                      ])}', style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.grey
                      )),
                      IconButton(onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            maxTime: DateTime(2050, 12, 1),
                            minTime: DateTime(2020, 1, 1),
                            currentTime: DateTime.now(),
                            locale: LocaleType.zh,
                            onConfirm: (date) {
                              isSelectedDate.value = false;
                            },
                            onChanged: (date) {
                              selectedDate.value = date;
                              print(selectedDate);
                            });
                      }, icon: Icon(Icons.arrow_forward_ios, size: 15.sp,))
                    ],),
                    SykDivider(context, 2),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.userList.value = [];
                  Get.back();
                }, child: Text("保存"), style: ButtonStyle(
                fixedSize:
                MaterialStateProperty.all(const Size(300, 50)),
              ),)
            ],
          ),
        );
      }),
    );
  }
}
