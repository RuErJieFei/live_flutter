import 'package:get/get.dart';

import '../../controllers/enter_school/enter_school_detail_controller.dart';

class EnterSchoolDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolDetailController>(
      () => EnterSchoolDetailController(),
    );
  }
}
