import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:wit_niit/app/modules/contacts/controllers/user_info_controller.dart';

class UserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserInfoController>(() => UserInfoController());
  }
}
