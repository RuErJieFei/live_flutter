import 'package:get/get.dart';

import 'package:wit_niit/app/modules/wit_classroom/controllers/add_device_controller.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/room_group_controller.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/room_position_controller.dart';

import '../controllers/wit_classroom_controller.dart';

class WitClassroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeviceController>(
      () => AddDeviceController(),
    );
    Get.lazyPut<RoomPositionController>(
      () => RoomPositionController(),
    );
    Get.lazyPut<RoomGroupController>(
      () => RoomGroupController(),
    );
    Get.lazyPut<WitClassroomController>(
      () => WitClassroomController(),
    );
  }
}
