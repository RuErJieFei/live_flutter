import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/user_group_model.dart';
import 'package:wit_niit/app/modules/wit_classroom/views/wit_classroom_view.dart';
import 'package:wit_niit/main.dart';

class RoomPositionController extends GetxController {
  TextEditingController positionNameTf = TextEditingController();
  var groupList = <UserGroupModel>[].obs;
  var groupId = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserGroup();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadUserGroup() async {
    var id = SpUtil.getString("userId");
    try {
      List data = await request.get("/iot/manage/group/all?userId=$id");
      data.forEach((e) {
        groupList.add(UserGroupModel.fromJson(e));
        // UserGroupModel group = UserGroupModel.fromJson(e);
        // userGroupMap['${group.id}'] = group;
      });
      groupId.value = groupList[0].id!;
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  void createPosition() async {
    var id = SpUtil.getString("userId");
    if (positionNameTf.text == '') {
      EasyLoading.showError('组名不能为空');
      return;
    }
    try {
      LogUtil.v(groupId.value);
      var data = await request.post(
          "/iot/manage/room/create?userId=${id}&groupId=${groupId}&roomName=${positionNameTf.text}");
      positionNameTf.text = '';
      Get.back();
      Get.to(() => WitClassroomView());
    } catch (e) {
      LogUtil.v(e);
      EasyLoading.showToast(e.toString());
    }
  }

  void changeGroup(v) {
    LogUtil.v(v);
    groupList.map((element) {
      if (v == element.groupName) {
        groupId.value = element.id!;
      }
    });
  }
}
