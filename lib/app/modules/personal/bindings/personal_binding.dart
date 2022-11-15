import 'package:get/get.dart';

import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';

import '../controllers/personal_controller.dart';

class PersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfoController>(
      () => PersonalInfoController(),
    );
    Get.lazyPut<PersonalController>(
      () => PersonalController(),
    );
  }
}
