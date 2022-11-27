import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
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
    request.post('/users/edit', data: dataForm).then((data) {
      // 更新缓存的用户信息
      user?.name = nameTf.text;
      SpUtil.putObject("user", user!);
      // 通讯录当前用户信息更新
      var msgCto = Get.find<MessageController>();
      // 通讯里里我的信息
      var curUser = msgCto.contactsMap['${user?.id}'];
      curUser?.name = nameTf.text;
      SpUtil.putObject('contactList', msgCto.contactsMap);
      // LogUtil.v('通讯录信息 ${msgCto.contactsMap['${user?.id}']?.name}');

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
    var data = await request
        .get("http://124.221.232.15:8082/users/getUserNoToken/$id");
    UserModel user = UserModel.fromJson(data);
    SpUtil.putObject("user", user);
  }
}
