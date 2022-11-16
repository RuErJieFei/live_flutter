import 'package:get/get.dart';

import '../../controllers/enter_school/enter_school_from_controller.dart';

class EnterSchoolFromBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolFromController>(
      () => EnterSchoolFromController(),
    );
  }
}
