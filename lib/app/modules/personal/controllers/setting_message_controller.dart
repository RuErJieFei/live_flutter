import 'package:get/get.dart';

class SettingMessageController extends GetxController {
  var isReceive = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeStatus(bool flag) {
    isReceive.value = flag;
  }
}
