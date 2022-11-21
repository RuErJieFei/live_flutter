import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_ding_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_email_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_phone_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_wechat_binding.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';
import 'package:wit_niit/app/modules/personal/views/personal_ding_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_email_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_phone_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_wechat_view.dart';

class SettingAccountController extends GetxController {
  /// 个人信息列表数据
  var accountList = [].obs;

  /// 添加个人列表信息数据
  void addInfo() {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

    accountList.add(
      PersonalInfo('微信',
          content: 'zk12345678',
          onPress: () => Get.to(() => PersonalWechatView(),
              binding: PersonalWechatBinding())),
    );
    accountList.add(
      PersonalInfo('钉钉',
          content: '12345678',
          onPress: () =>
              Get.to(() => PersonalDingView(), binding: PersonalDingBinding())),
    );
    accountList.add(
      PersonalInfo('手机号',
          content: '${user?.phone}',
          onPress: () => Get.to(() => PersonalPhoneView(),
              binding: PersonalPhoneBinding())),
    );
    accountList.add(
      PersonalInfo('电子邮箱',
          content: '${user?.email}',
          onPress: () => Get.to(() => PersonalEmailView(),
              binding: PersonalEmailBinding())),
    );
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化列表数据
    addInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
