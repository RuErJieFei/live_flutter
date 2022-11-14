import 'package:get/get.dart';

import '../controllers/campus_mail_controller.dart';

class CampusMailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CampusMailController>(
      () => CampusMailController(),
    );
  }
}
