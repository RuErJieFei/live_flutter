import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/app/modules/personal/views/personal_info_view.dart';
import 'package:wit_niit/main.dart';

class PersonalPhoneBindController extends GetxController {
  TextEditingController phoneTf = TextEditingController();
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
    if (phoneTf.text.length != 11) {
      EasyLoading.showToast('请输入正确的手机号');
      return;
    }
    if (!sendCodeBtn) {
      LogUtil.v('获取验证码~~');
      startTimer();
      // AuthClient.sendSms(phoneTf.text, "+86");
      request.post('/users/sendSms', data: {"phone": phoneTf.text});
    }
  }

  /// 下一步
  nextStep() async {
    if (phoneTf.text.length != 11) {
      EasyLoading.showToast('请输入正确的手机号');
      return;
    }
    if (vCodeTf.text.length == 0) {
      EasyLoading.showToast('请输入验证码');
      return;
    }
    request.post('/users/changPhone',
        data: {"phone": phoneTf.text, "code": vCodeTf.text}).then((data) {
      var personal = Get.find<PersonalInfoController>();
      personal.changePhone(phoneTf.text);

      EasyLoading.showToast('手机号修改成功');
      Get.offAll(() => PersonalInfoView());
    }).catchError((_) {
      EasyLoading.showError('修改手机号错误');
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
