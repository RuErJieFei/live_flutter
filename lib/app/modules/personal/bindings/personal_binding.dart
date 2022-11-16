import 'package:get/get.dart';

import 'package:wit_niit/app/modules/personal/controllers/personal_avatar_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_email_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_gender_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_name_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_phone_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_status_controller.dart';

import '../controllers/personal_controller.dart';

class PersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalStatusController>(
      () => PersonalStatusController(),
    );
    Get.lazyPut<PersonalPhoneController>(
      () => PersonalPhoneController(),
    );
    Get.lazyPut<PersonalGenderController>(
      () => PersonalGenderController(),
    );
    Get.lazyPut<PersonalNameController>(
      () => PersonalNameController(),
    );
    Get.lazyPut<PersonalInfoController>(
      () => PersonalInfoController(),
    );
    Get.lazyPut<PersonalController>(
      () => PersonalController(),
    );
  }
}
