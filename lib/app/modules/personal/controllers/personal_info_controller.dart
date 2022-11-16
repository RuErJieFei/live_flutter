import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';

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

    personalInfoList.add(PersonalInfo('头像', '${user?.photo}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('姓名', '${user?.name}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('性别', '${gender}', () => LogUtil.v('跳转页面')),);
    // personalInfoList.add(PersonalInfo('个人状态', '😃开心', () => Get.to(() => PersonalInfoView())),);
    personalInfoList.add(PersonalInfo('个人状态', '暂无', () => () => LogUtil.v('跳转页面')),);
    // ?? -> user?.company为空，返回操作符 右边的值
    personalInfoList.add(PersonalInfo('所在企业', '${user?.company??'暂无'}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('手机', '${user?.phone}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('邮箱', '${user?.email}', () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('职务', '暂无', () => () => LogUtil.v('跳转页面')),);
    personalInfoList.add(PersonalInfo('组别', '暂无', () => LogUtil.v('跳转页面')),);
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
