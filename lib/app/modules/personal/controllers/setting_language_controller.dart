import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/model/personal_gender_model.dart';

class SettingLanguageController extends GetxController {
  var languageList = <PersonalGender>[].obs;
  // UserModel? user = SpUtil.getObj(
  //     "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  @override
  void onInit() {
    super.onInit();
    languageList.add(PersonalGender(
        genderName: '跟随系统语言', genderValue: 'system', isSelect: true));
    languageList.add(PersonalGender(
        genderName: '简体中文', genderValue: 'zh_hans', isSelect: false));
    languageList.add(PersonalGender(
        genderName: '繁体中文', genderValue: 'zh_hant', isSelect: false));
    languageList.add(PersonalGender(
        genderName: 'English', genderValue: 'en', isSelect: false));

    // languageList.forEach((element) {
    //   if (user?.gender == element.genderValue) {
    //     element.isSelect = element.isSelect == true ? false : true;
    //   }
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeGender(PersonalGender personalGender) {
    languageList.forEach((element) {
      if (personalGender.genderValue == element.genderValue) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });
    languageList.refresh();
  }
}
