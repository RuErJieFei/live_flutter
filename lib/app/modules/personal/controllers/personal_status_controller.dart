import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/model/personal_status_model.dart';

class PersonalStatusController extends GetxController {
  var selected = false.obs;
  var personalStatusList = <PersonalStatus>[].obs;

  @override
  void onInit() {
    personalStatusList
        .add(PersonalStatus(statusIcon: '➕', statusLabel: '添加新状态'));
    personalStatusList.add(
        PersonalStatus(statusIcon: '🔕', statusLabel: '请勿打扰', isSelect: false));
    personalStatusList.add(PersonalStatus(
        statusIcon: '🧑‍💻', statusLabel: '办公中', isSelect: false));
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

  void changeSelected(PersonalStatus personalStatus) {
    personalStatusList.forEach((element) {
      if (personalStatus == element) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });
    personalStatusList.refresh();
  }
}
