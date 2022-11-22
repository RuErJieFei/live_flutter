import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';

class PersonalController extends GetxController {
  var user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    user.value = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>))!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 改变用户名
  void changeName(String name) {
    user.value.name = name;
    user.refresh();
  }

  // 改变头像
  void changeAvatar(String url) {
    user.value.photo = url;
    user.refresh();
  }
}
