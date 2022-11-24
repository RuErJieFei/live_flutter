import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/contacts/model/user_info_model.dart';
import 'package:wit_niit/main.dart';

class UserInfoController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    userId.value = Get.arguments;
    getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final userId = ''.obs;
  var user = UserInfoModel().obs;

  ///用户详情
  void getUserInfo() async {
    Map<String, dynamic> params = {"userId": userId};
    await request
        .post("${NetUrl.message_HostName}/community/userInfo", params: params)
        .then((data) {
      UserInfoModel result = UserInfoModel.fromJson(data["data"]);
      user.value = result;
      LogUtil.v(result.name);
    });
  }
}
