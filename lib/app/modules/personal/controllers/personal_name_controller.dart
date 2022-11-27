import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/main.dart';

class PersonalNameController extends GetxController {
  TextEditingController nameTf = TextEditingController();
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  @override
  void onInit() {
    super.onInit();

    nameTf.text = user?.name ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeName() {
    if (nameTf.text == user?.name) {
      EasyLoading.showToast('和原姓名相同');
      return;
    }
    var dataForm = {
      "photo": "${user?.photo}",
      "gender": "${user?.gender}",
      "name": "${nameTf.text}",
      "id": "${user?.id}"
    };
    getUserInfo(dataForm["id"]);
    request
        .post('${NetUrl.user_HostName}/users/edit', data: dataForm)
        .then((data) {
      /// 获取用户信息
      getUserInfo(data["id"]);

      var personalInfo = Get.find<PersonalInfoController>();
      personalInfo.changeName(nameTf.text);

      var personal = Get.find<PersonalController>();
      personal.changeName(nameTf.text);
      EasyLoading.showToast('修改成功');
      Get.back();
    }).catchError((_) {
      EasyLoading.showError('修改个人资料错误');
    });
  }

  /// 获取当前登录用户信息
  void getUserInfo(id) async {
    var token = SpUtil.getString('token');
    LogUtil.v(token);
    var data = await request.get(
      "${NetUrl.user_HostName}/users/getUser/$id",
      headers: {"token": token},
    );
    UserModel user = UserModel.fromJson(data);
    SpUtil.putObject("user", user);
  }
}
