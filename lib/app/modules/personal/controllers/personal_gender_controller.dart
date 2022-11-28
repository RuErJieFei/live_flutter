import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/app/modules/personal/model/personal_gender_model.dart';
import 'package:wit_niit/main.dart';

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
        if (element.isSelect == true) {
          EasyLoading.showToast('当前性别已经为${element.genderName}');
          return;
        } else {
          element.isSelect = true;

          var dataForm = {
            "photo": "${user?.photo}",
            "gender": "${personalGender.genderValue}",
            "name": "${user?.name}",
            "id": "${user?.id}"
          };

          request.post('/users/edit', data: dataForm).then((data) {
            // 更新缓存的用户信息
            user?.gender = personalGender.genderValue;
            SpUtil.putObject("user", user!);

            var personal = Get.find<PersonalInfoController>();
            personal.changeGender(personalGender.genderName);
            EasyLoading.showToast('修改成功');
            Get.back();
          }).catchError((_) {
            EasyLoading.showError('修改个人资料错误');
          });
        }
      } else {
        element.isSelect = false;
      }
    });
    genderList.refresh();
  }

  /// 获取当前登录用户信息
  void getUserInfo(id) async {
    var data = await request
        .get("http://124.221.232.15:8082/users/getUserNoToken/$id");
    UserModel user = UserModel.fromJson(data);
    SpUtil.putObject("user", user);
  }
}
