import 'package:get/get.dart';

import '../controllers/wit_classroom_controller.dart';

class WitClassroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WitClassroomController>(
      () => WitClassroomController(),
    );
  }
}
