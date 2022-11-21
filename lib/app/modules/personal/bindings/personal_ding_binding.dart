import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_ding_controller.dart';

class PersonalDingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDingController>(
      () => PersonalDingController(),
    );
  }
}
