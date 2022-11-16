import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_phone_controller.dart';

class PersonalPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalPhoneController>(
      () => PersonalPhoneController(),
    );
  }
}
