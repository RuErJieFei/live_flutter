import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_avatar_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_email_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_gender_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_name_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_phone_binding.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_status_binding.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';
import 'package:wit_niit/app/modules/personal/views/personal_avatar_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_email_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_gender_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_name_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_phone_view.dart';
import 'package:wit_niit/app/modules/personal/views/personal_status_view.dart';

class PersonalInfoController extends GetxController {
  /// 个人信息列表数据
  var personalInfoList = [].obs;

  /// 添加个人列表信息数据
  void addInfo() {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    // 性别列表
    Map<String, String> genderList = {
      "M": "男",
      "F": "女",
      "U": "未知",
    };
    // 用户性别
    String gender = '';
    genderList.forEach((key, value) {
      // 遍历 拿到对应的性别
      if (key == user?.gender) {
        gender = value;
      }
    });

    personalInfoList.add(
      PersonalInfo(
          '头像',
          '${user?.photo}',
          () => Get.to(() => PersonalAvatarView(),
              binding: PersonalAvatarBinding())),
    );
    personalInfoList.add(
      PersonalInfo(
          '姓名',
          '${user?.name}',
          () =>
              Get.to(() => PersonalNameView(), binding: PersonalNameBinding())),
    );
    personalInfoList.add(
      PersonalInfo(
          '性别',
          '${gender}',
          () => Get.to(() => PersonalGenderView(),
              binding: PersonalGenderBinding())),
    );
    // personalInfoList.add(PersonalInfo('个人状态', '😃开心', () => Get.to(() => PersonalInfoView())),);
    personalInfoList.add(
      PersonalInfo(
          '个人状态',
          '暂无',
          () => Get.to(() => PersonalStatusView(),
              binding: PersonalStatusBinding())),
    );
    // ?? -> user?.company为空，返回操作符 右边的值
    // personalInfoList.add(PersonalInfo('所在企业', '${user?.company??'暂无'}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(
      PersonalInfo(
          '手机',
          '${user?.phone}',
          () => Get.to(() => PersonalPhoneView(),
              binding: PersonalPhoneBinding())),
    );
    personalInfoList.add(
      PersonalInfo(
          '邮箱',
          '${user?.email}',
          () => Get.to(() => PersonalEmailView(),
              binding: PersonalEmailBinding())),
    );
    personalInfoList.add(
      PersonalInfo('职务', '暂无', () => () => LogUtil.v('跳转页面')),
    );
    personalInfoList.add(
      PersonalInfo('组别', '暂无', () => LogUtil.v('跳转页面')),
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
