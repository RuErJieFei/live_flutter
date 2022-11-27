import 'package:get/get.dart';
import 'package:wit_niit/app/modules/ask_leave/controllers/ask_leave_student_controller.dart';

import '../controllers/ask_leave_controller.dart';

class AskLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskLeaveController>(
      () => AskLeaveController(),
    );
    Get.lazyPut<AskLeaveStudentController>(
      () => AskLeaveStudentController(),
    );
  }
}
