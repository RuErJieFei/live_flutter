import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/user_group_model.dart';
import 'package:wit_niit/app/modules/wit_classroom/views/room_position_view.dart';
import 'package:wit_niit/main.dart';

class RoomGroupController extends GetxController {
  TextEditingController groupNameTf = TextEditingController();
  var groupList = <UserGroupModel>[].obs;
  var userGroupMap = <String, UserGroupModel>{}.obs;
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
        UserGroupModel group = UserGroupModel.fromJson(e);
        userGroupMap['${group.id}'] = group;
      });
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  void createGroup() async {
    var id = SpUtil.getString("userId");
    if (groupNameTf.text == '') {
      EasyLoading.showError('组名不能为空');
      return;
    }
    try {
      // var data = await request.post(
      //     "/iot/manage/group/create?userId=${id}&groupName=${groupNameTf.text}");
      // LogUtil.v(data);
      groupNameTf.text = '';
      Get.back();
      Get.to(() => RoomPositionView());
    } catch (e) {
      LogUtil.v(e);
      EasyLoading.showToast(e.toString());
    }
  }
}
