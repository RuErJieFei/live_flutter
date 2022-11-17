import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/model/personal_gender_model.dart';

class PersonalGenderController extends GetxController {
  final gender = false.obs;
  var genderList = <PersonalGender>[].obs;
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  @override
  void onInit() {
    super.onInit();
    genderList.add(
        PersonalGender(genderName: '男', genderValue: 'M', isSelect: false));
    genderList.add(
        PersonalGender(genderName: '女', genderValue: 'F', isSelect: false));
    genderList.add(
        PersonalGender(genderName: '未知', genderValue: 'U', isSelect: false));

    genderList.forEach((element) {
      if (user?.gender == element.genderValue) {
        element.isSelect = element.isSelect == true ? false : true;
      }
    });
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
    genderList.forEach((element) {
      if (personalGender.genderValue == element.genderValue) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });
    genderList.refresh();
  }
}
