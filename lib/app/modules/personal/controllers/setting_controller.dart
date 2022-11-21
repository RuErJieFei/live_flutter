import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_about_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_account_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_language_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_message_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_mode_binding.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';
import 'package:wit_niit/app/modules/personal/views/setting_about_view.dart';
import 'package:wit_niit/app/modules/personal/views/setting_account_view.dart';
import 'package:wit_niit/app/modules/personal/views/setting_language_view.dart';
import 'package:wit_niit/app/modules/personal/views/setting_message_view.dart';
import 'package:wit_niit/app/modules/personal/views/setting_mode_view.dart';

class SettingController extends GetxController {
  /// 个人信息列表数据
  var settingList = [].obs;

  /// 添加个人列表信息数据
  void addInfo() {
    settingList.add(
      PersonalInfo('账号与安全',
          onPress: () => Get.to(() => SettingAccountView(),
              binding: SettingAccountBinding())),
    );
    settingList.add(
      PersonalInfo('消息通知',
          onPress: () => Get.to(() => SettingMessageView(),
              binding: SettingMessageBinding())),
    );
    settingList.add(PersonalInfo('通用'));
    settingList.add(
      PersonalInfo('深色模式',
          onPress: () =>
              Get.to(() => SettingModeView(), binding: SettingModeBinding())),
    );
    settingList.add(
      PersonalInfo('多语言',
          onPress: () => Get.to(() => SettingLanguageView(),
              binding: SettingLanguageBinding())),
    );
    settingList.add(
      PersonalInfo(
        '清除缓存',
        content: '4.88M',
        onPress: () => Get.defaultDialog(
          title: '提示',
          middleText: '根据缓存文件的大小，清理时间从几秒到几分钟不等，请耐心等待。',
          middleTextStyle: BaseStyle.grayContentStyle,
          confirm: TextButton(
            onPressed: () => Get.back(),
            child: Container(
              child: Text(
                '取消',
                textAlign: TextAlign.center,
              ),
              width: Get.width / 3,
            ),
          ),
          cancel: TextButton(
            onPressed: () => Get.back(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black87,
            ),
            child: Container(
              child: Text(
                '确定',
                textAlign: TextAlign.center,
              ),
              width: Get.width / 3,
            ),
          ),
        ),
      ),
    );
    settingList.add(
      PersonalInfo('关于智慧南工',
          onPress: () =>
              Get.to(() => SettingAboutView(), binding: SettingAboutBinding())),
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
