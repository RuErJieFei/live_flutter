import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_attachment_video_view.dart';
import 'package:wit_niit/app/modules/micro_disk/views/micro_disk_view.dart';
import '../../../micro_disk/bindings/micro_disk_binding.dart';
import '../../../micro_disk/controllers/micro_disk_controller.dart';
import '../../model/schedule_model_release.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/participants_add_view.dart';
import '../../../../../main.dart';
import '../../controllers/schedule_controller.dart';

class ScheduleAddView extends GetView<SchedulePageController> {
  const ScheduleAddView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MicroDiskController());
    final size = MediaQuery.of(context).size;
    var thisDate = formatDate(controller.selectedStartDay.value,
        [yyyy, "-", mm, "-", dd, " ", HH, ":",nn, ":", ss]);
    addScheduleInfo() async {
      print(thisDate);
      var data = {
        "organizationId": SpUtil.getString("userId"),
        "topic": controller.topicController.value.text,
        // "participant": [1,2,3,4,5,7],
        "startTime": thisDate,
        // "duration": 60,
        "isAllday": false,
        "address": controller.addressController.value.text,
        "attachment": controller.attachmentList.map((element) => element.title).toList(),
        "description": controller.descriptionController.value.text,
        "alertTime": 15,
        "isRepeat": false,
        "isActive": false,
        "calender": "????????????"
      };
      var resp = await request.post("/schedule/addSchedule", data: data);
      if (resp == 1) {
        controller.topicController.value.clear();
        controller.addressController.value.clear();
        controller.descriptionController.value.clear();
        controller.scheduleList.value = await controller.getScheduleByDate();
        controller.scheduleList.value = controller.scheduleList
            .map((element) => Data.fromJson(element))
            .toList();
        EasyLoading.showToast("????????????");
        Get.back();
      } else {
        EasyLoading.showToast("????????????");
      }
      print(resp);
    }

    return Scaffold(
      /// ?????????????????????
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("????????????"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.attachmentList.value = [];
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Obx(() {
            return Column(
              children: [
                Expanded(flex: 1, child: _Topic(context)),
                SykDivider(context, 8),
                Expanded(flex: 1, child: _Participants(context)),
                SykDivider(context, 8),
                Expanded(flex: 3, child: _TimeComponent(context)),
                SykDivider(context, 8),
                Expanded(flex: 1, child: _Address(context)),
                SykDivider(context, 8),
                Expanded(flex: 5,child: _Attachment(context)),
                SykDivider(context, 8),
                Expanded(flex: 2,child: _Description(context)),
                // SykDivider(context, 8),
                // Expanded(flex: 5, child: _MoreComponent(context)),
                ElevatedButton(
                    onPressed: () {
                      addScheduleInfo();
                    },
                    child: Text("??????"))
              ],
            );
          }),
        ),
      ),
    );
  }

  // @override
  // // TODO: implement controller
  // SchedulePageController get controller => super.controller;

  Widget _Topic(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: controller.topicController.value,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "?????????????????????",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _Participants(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: Row(children: [
        Text(
          "???????????????",
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
                  "??????",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                GestureDetector(
                  child: controller.isAllDay.value
                      ? Text("${formatDate(DateTime.now(), [
                              mm,
                              "???",
                              dd,
                              "??? ",
                            ])}")
                      : Text("${formatDate(controller.selectedStartDay.value, [
                              mm,
                              "???",
                              dd,
                              "???     ",
                              HH,
                              ":",
                              nn
                            ])}"),
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        maxTime: DateTime(2050, 12, 1),
                        minTime: DateTime(2020, 1, 1),
                        currentTime: DateTime.now(),
                        locale: LocaleType.zh, onConfirm: (date) {
                      if (controller.isAllDay.value == true) {
                        controller.selectedStartDay.value = DateTime.now();
                      } else {
                        controller.selectedStartDay.value = date;
                      }

                      print('change ${controller.selectedStartDay.value}');
                    });
                  },
                ),
              ],
            ),
            SykDivider(context, 2),
            Row(
              children: [
                Text(
                  "??????",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                GestureDetector(
                  child: controller.isAllDay.value
                      ? Text(
                          "${formatDate(DateTime.now(), [
                                mm,
                                "???",
                                dd,
                                "??? ",
                              ])}",
                        )
                      : Text(
                          "${formatDate(controller.selectedEndDay.value, [
                                mm,
                                "???",
                                dd,
                                "???     ",
                                HH,
                                ":",
                                nn
                              ])}",
                          style: controller.selectedEndDay.value
                                  .isBefore(controller.selectedStartDay.value)
                              ? TextStyle(color: Colors.red)
                              : TextStyle(color: Colors.black)),
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        maxTime: DateTime(2050, 12, 1),
                        minTime: DateTime(2020, 1, 1),
                        currentTime: DateTime.now(),
                        locale: LocaleType.zh, onConfirm: (date) {
                      if (controller.isAllDay.value == true) {
                        controller.selectedEndDay.value = DateTime.now();
                      } else {
                        controller.selectedEndDay.value = date;
                      }
                      print('change ${controller.selectedEndDay.value}');
                    });
                  },
                ),
              ],
            ),
            SykDivider(context, 2),
            Row(
              children: [
                Text(
                  "??????",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Spacer(),
                Switch(
                  value: controller.isAllDay.value,
                  onChanged: (val) {
                    controller.isAllDay.value = val;
                    print(controller.isAllDay.value);
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
        controller: controller.addressController.value,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "???????????????",
            hintStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _Attachment(BuildContext context) {
    /// Pick an image
    Future getImage() async {
      List<Media>? res = await ImagesPicker.pick(
        count: 3,
        pickType: PickType.image,
      );
      if (controller.attachmentList.length <= 5) {
        res!.forEach((element) {
          var strPathList = element.thumbPath.toString().split("/");
          controller.attachmentList.add(SykListItem(
              Image.file(
                new File(element.path),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              strPathList[strPathList.length - 1],
              'image',element.path));
        });
      } else {
        EasyLoading.showToast("??????5?????????");
        return;
      }
    }

    Future getVideoFromGallery() async {
      List<Media>? res = await ImagesPicker.pick(
        count: 3,
        pickType: PickType.video,
      );
      if (controller.attachmentList.length <= 5) {
        res!.forEach((element) {
          var strPathList = element.path.toString().split("/");
          controller.attachmentList.add(SykListItem(
              Image.file(
                new File(element.thumbPath!),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              strPathList[strPathList.length - 1],
              'video',element.path));
        });
      } else {
        EasyLoading.showToast("??????5?????????");
        return;
      }
    }

    return 
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50.h,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                            content: Container(
                              width: 0.8.sw,
                              height: 0.5.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => CupertinoAlertDialog(
                                                  content: Container(
                                                    width: 0.8.sw,
                                                    height: 0.5.sw,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              getImage();
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "????????????",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )),
                                                        SykDivider(context, 2),
                                                        GestureDetector(
                                                            onTap: () async {
                                                              getVideoFromGallery();
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "????????????",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )),
                                                        SykDivider(context, 2),
                                                        GestureDetector(
                                                            onTap: () {
                                                              ImagesPicker
                                                                  .openCamera(
                                                                pickType: PickType
                                                                    .image,
                                                                maxTime:
                                                                    15, // record video max time
                                                              );
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "??????",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )),
                                                        SykDivider(context, 2),
                                                        GestureDetector(
                                                            onTap: () async {
                                                              ImagesPicker
                                                                  .openCamera(
                                                                pickType: PickType
                                                                    .video,
                                                                maxTime:
                                                                    15, // record video max time
                                                              );
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "??????",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            )),
                                                        SykDivider(context, 2),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Text(
                                        "????????????/??????",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SykDivider(context, 2),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "??????????????????",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SykDivider(context, 2),
                                  GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "??????????????????",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                  SykDivider(context, 2),
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => MicroDiskView(),
                                            binding: MicroDiskBinding());
                                      },
                                      child: Text(
                                        "??????????????????",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                ],
                              ),
                            ),
                          ));
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "????????????...",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
              ),

              //         SizedBox(
              //           height: 200.h,
              //           width: 1.sw,
              //           child: ListView.builder(
              //               itemCount: controller.attachmentList.length,
              //               itemBuilder: (BuildContext context, index) {
              //               var strPathList =  controller.attachmentList[index].thumbPath.toString().split("/");
              //                 return ListTile(leading: Image.file(
              //                   new File(controller.attachmentList[index].thumbPath),
              //                   fit: BoxFit.cover,width: 40,height: 40,),title: Text("${strPathList[strPathList.length -1]}"),);
              //               }),
              //         )
              //       ],
              //     )
              // );

              SizedBox(
                height: 200.h,
                width: 1.sw,
                child: ListView.builder(
                    itemCount: controller.attachmentList.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.to(()=> VideoApp());
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeContent()));
                        },
                        child: ListTile(
                          leading: controller.attachmentList[index].item,
                          title: Text("${controller.attachmentList[index].title}"),
                          trailing: IconButton(onPressed: (){
                            controller.attachmentList.removeAt(index);
                          }, icon: Icon(Icons.clear,size: 16,)),
                        ),
                      );
                    }),
              )
            ],
          ),
    );
  }

  Widget _Description(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: TextFormField(
        controller: controller.descriptionController.value,
        maxLines: 3,
        //????????????
        validator: (value) {},
        //??? Form ???????????????????????? Save?????????????????????
        onSaved: (value) {},
        // ??????????????????????????????????????????
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            hintText: "??????",
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
                "??????",
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
                "??????",
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
                "????????????",
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
                "??????",
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

Widget SykDivider(BuildContext context, double thick) {
  return Divider(
    thickness: thick.h,
    color: Colors.grey.shade200,
    indent: 0,
    endIndent: 0,
  );
}

class SykListItem {
  final Widget item;
  final String title;
  final String type;
  final String file;
  SykListItem(this.item, this.title, this.type, this.file);
}
