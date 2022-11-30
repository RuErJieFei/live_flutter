import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/device_model.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/room_model.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/user_group_model.dart';
import 'package:wit_niit/main.dart';

class WitClassroomController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var groupList = <UserGroupModel>[].obs;
  var roomList = <RoomModel>[].obs;
  var deviceList = <DeviceModel>[].obs;
  // 用户组id
  var groupId = 0.obs;
  // 教室id
  var roomId = 0.obs;
  var tabs = <String>[].obs;
  // late TabController tabController;
  // var len = 0;
  @override
  void onInit() async {
    super.onInit();
    loadUserGroup();
    // tabController = TabController(length: len, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<int> loadUserGroup() async {
    var id = SpUtil.getString("userId");
    try {
      List data = await request.get("/iot/manage/group/all?userId=$id");
      if (data.isNotEmpty) {
        data.forEach((e) {
          groupList.add(UserGroupModel.fromJson(e));
          // UserGroupModel group = UserGroupModel.fromJson(e);
          // userGroupMap['${group.id}'] = group;
        });
        groupId.value = groupList[0].id!;
        var res = await loadGroupPosition(groupId.value);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    } finally {
      return tabs.length;
    }
  }

  Future<int> loadGroupPosition(int groupId) async {
    var id = SpUtil.getString("userId");
    try {
      List data = await request
          .get("/iot/manage/room/all?userId=${id}&groupId=${groupId}");
      LogUtil.v(data);
      if (data.length != 0) {
        data.forEach((e) {
          var room = RoomModel.fromJson(e);
          tabs.add(room.roomName!);
          roomList.add(RoomModel.fromJson(e));
          // groupId.value = groupList[0].id!;
          // UserGroupModel group = UserGroupModel.fromJson(e);
          // userGroupMap['${group.id}'] = group;
        });
        roomId.value = roomList[0].id!;
        loadRoomDevice(roomList[0].id!);
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    } finally {
      return tabs.length;
    }
  }

  void loadRoomDevice(int roomId) async {
    try {
      List data =
          await request.get("/iot/manage/room/devices?roomId=${roomId}");
      // deviceList.value = data;
      LogUtil.v(data);
      if (data.length != 0) {
        data.forEach((e) {
          var device = DeviceModel.fromJson(e);
          deviceList.add(device);
          // groupId.value = groupList[0].id!;
          // UserGroupModel group = UserGroupModel.fromJson(e);
          // userGroupMap['${group.id}'] = group;
        });
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
