import 'package:get/get.dart';

import 'package:wit_niit/app/modules/personal/controllers/personal_avatar_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_email_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_name_controller.dart';

class PersonalNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalNameController>(
          () => PersonalNameController(),
    );
  }
}