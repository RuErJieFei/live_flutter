import 'package:get/get.dart';

import '../controllers/ask_leave_controller.dart';

class AskLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskLeaveController>(
      () => AskLeaveController(),
    );
  }
}
