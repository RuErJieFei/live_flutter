import 'package:get/get.dart';

import '../../controllers/enter_school/enter_school_index_controller.dart';

class EnterSchoolIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolIndexController>(
      () => EnterSchoolIndexController(),
    );
  }
}
