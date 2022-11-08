import 'package:get/get.dart';

class EnterSchoolFromController extends GetxController {
  // static EnterSchoolFromController get to => Get.find(); // 添加这一行
  final today = true.obs;
  final isGreen = 0.obs;

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

  void selectedDate(selected) {
    today.value = selected;
  }

  void setGreen(selected) => isGreen.value = selected;
}
