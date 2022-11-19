import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/controllers/password_controller.dart';

/// 创建时间：2022/11/19
/// 作者：w2gd
/// 描述：

class PasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordController>(() => PasswordController());
  }
}
