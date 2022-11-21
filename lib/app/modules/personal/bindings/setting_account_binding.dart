import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_account_controller.dart';

class SettingAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingAccountController>(
      () => SettingAccountController(),
    );
  }
}
