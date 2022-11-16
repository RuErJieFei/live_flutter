import 'package:get/get.dart';

import 'package:wit_niit/app/modules/personal/controllers/personal_avatar_controller.dart';

class PersonalAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalAvatarController>(
          () => PersonalAvatarController(),
    );
  }
}