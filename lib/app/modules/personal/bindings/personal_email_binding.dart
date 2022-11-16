import 'package:get/get.dart';

import 'package:wit_niit/app/modules/personal/controllers/personal_avatar_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_email_controller.dart';

class PersonalEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalEmailController>(
          () => PersonalEmailController(),
    );
  }
}