import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/wit_classroom_controller.dart';
import 'package:wit_niit/app/modules/wit_classroom/model/device_type_model.dart';
import 'package:wit_niit/main.dart';

class AddDeviceController extends GetxController {
  var deviceTypeList = <DeviceTypeModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadDeviceType();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadDeviceType() async {
    try {
      List data = await request.get("/iot/manage/device/type");
      LogUtil.v(data);
      if (data.length != 0) {
        data.forEach((e) {
          var type = DeviceTypeModel.fromJson(e);
          deviceTypeList.add(type);
          // roomList.add(RoomModel.fromJson(e));
          // groupId.value = groupList[0].id!;
          // UserGroupModel group = UserGroupModel.fromJson(e);
          // userGroupMap['${group.id}'] = group;
        });
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  void addDevice(int typeId) async {
    var userId = SpUtil.getString("userId");
    var witClassRoom = Get.find<WitClassroomController>();
    // LogUtil.v(witClassRoom.roomId);
    try {
      var dataForm = {};
      if (typeId == 1) {
        dataForm = {
          "deviceNum": 1,
          "deviceName": "智能LED灯",
          "clientId": "Led",
          "deviceUsername": "LedManage",
          "devicePassword": "666666",
          "topic": "led_topic",
          "typeId": typeId,
          "roomId": witClassRoom.roomId,
          "userId": "$userId"
        };
      } else if (typeId == 2) {
        dataForm = {
          "deviceNum": 1,
          "deviceName": "空调控制器",
          "clientId": "AirCondition",
          "deviceUsername": "ACManage",
          "devicePassword": "666666",
          "topic": "ac_topic",
          "typeId": typeId,
          "roomId": witClassRoom.roomId,
          "userId": "$userId"
        };
      } else if (typeId == 3) {
        dataForm = {
          "deviceNum": 1,
          "deviceName": "温湿度监测器",
          "clientId": "DH11",
          "deviceUsername": "DH11Manage",
          "devicePassword": "666666",
          "topic": "dh11_topic",
          "typeId": typeId,
          "roomId": witClassRoom.roomId,
          "userId": "$userId"
        };
      }

      LogUtil.v(dataForm);
      var data =
          await request.post("/iot/manage/room/add-device", data: dataForm);
      LogUtil.v(data);

      // if (data.length != 0) {
      //   data.forEach((e) {
      //     var type = DeviceTypeModel.fromJson(e);
      //     deviceTypeList.add(type);
      //     // roomList.add(RoomModel.fromJson(e));
      //     // groupId.value = groupList[0].id!;
      //     // UserGroupModel group = UserGroupModel.fromJson(e);
      //     // userGroupMap['${group.id}'] = group;
      //   });
      // }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
