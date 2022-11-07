import 'package:get/get.dart';

import '../controllers/enter_school_controller.dart';

class EnterSchoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolController>(
      () => EnterSchoolController(),
    );
  }
}
