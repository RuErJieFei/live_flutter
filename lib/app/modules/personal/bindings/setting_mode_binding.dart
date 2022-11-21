import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_model_controller.dart';

class SettingModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingModelController>(
      () => SettingModelController(),
    );
  }
}
