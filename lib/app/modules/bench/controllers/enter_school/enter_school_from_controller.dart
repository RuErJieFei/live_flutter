import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';

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

  Future getImage() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 3,
      pickType: PickType.image,
    );
  }

  Future getPhoto() async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.video,
      maxTime: 15, // record video max time
    );
  }
}
