import 'package:authing_sdk/client.dart';
import 'package:authing_sdk/result.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/app/modules/personal/views/personal_info_view.dart';
import 'package:wit_niit/main.dart';

class PersonalEmailBindController extends GetxController {
  TextEditingController emailTf = TextEditingController();
  TextEditingController vCodeTf = TextEditingController();
  TimerUtil? _timerUtil;
  var vCodeStr = '获取验证码'.obs;

  // 是否点击验证码
  bool sendCodeBtn = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    cancelTimer();
  }

  ///开始倒计时
  void startTimer() {
    vCodeStr.value = '60秒后重发';

    _timerUtil = TimerUtil(mTotalTime: 60 * 1000);
    _timerUtil?.setOnTimerTickCallback((int tick) {
      int _tick = tick ~/ 1000;
      vCodeStr.value = '$_tick秒后重发';
      // 禁止按钮点击
      sendCodeBtn = true;

      if (_tick <= 0) {
        sendCodeBtn = false;
        vCodeStr.value = '重新获取';
        cancelTimer();
      }
    });
    _timerUtil?.startCountDown();
  }

  ///停止倒计时
  void cancelTimer() {
    sendCodeBtn = false;
    if (_timerUtil != null) {
      _timerUtil?.cancel();
    }
  }

  /// 获取验证码
  getVCode() async {
    if (!(emailTf.text.isEmail)) {
      EasyLoading.showToast('请输入正确的邮箱');
      return;
    }
    if (!sendCodeBtn) {
      LogUtil.v('获取验证码~~');
      startTimer();
      // 发送邮箱接口目前只能发验证邮箱 而不是 修改邮箱验证码的邮箱
      // request.post('${NetUrl.user_HostName}/users/sendEmail',
      //     data: {"email": emailTf.text});

      // Authing自带的 修改邮箱邮件方法
      AuthResult result =
          await AuthClient.sendEmail(emailTf.text, "CHANGE_EMAIL");
    }
  }

  /// 下一步
  nextStep() async {
    if (!(emailTf.text.isEmail)) {
      EasyLoading.showToast('请输入正确的邮箱');
      return;
    }
    if (vCodeTf.text.length == 0) {
      EasyLoading.showToast('请输入验证码');
      return;
    }
    request.post('/users/changeEmail',
        data: {"email": emailTf.text, "code": vCodeTf.text}).then((data) {
      /// 获取用户信息
      getUserInfo(SpUtil.getString('userId'));

      var personal = Get.find<PersonalInfoController>();
      personal.changeEmail(emailTf.text);

      EasyLoading.showToast('邮箱修改成功');
      Get.offAll(() => PersonalInfoView());
    }).catchError((_) {
      EasyLoading.showError('修改邮箱错误');
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
