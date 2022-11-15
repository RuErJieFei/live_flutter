import 'package:get/get.dart';

import '../controllers/enter_school_history_controller.dart';

class EnterSchoolHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolHistoryController>(
      () => EnterSchoolHistoryController(),
    );
  }
}
