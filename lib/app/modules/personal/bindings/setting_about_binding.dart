import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_about_controller.dart';

class SettingAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingAboutController>(
      () => SettingAboutController(),
    );
  }
}
