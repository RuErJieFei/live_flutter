import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_language_controller.dart';

class SettingLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingLanguageController>(
      () => SettingLanguageController(),
    );
  }
}
