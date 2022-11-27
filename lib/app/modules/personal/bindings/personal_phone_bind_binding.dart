import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_phone_bind_controller.dart';

class PersonalPhoneBindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalPhoneBindController>(
      () => PersonalPhoneBindController(),
    );
  }
}
