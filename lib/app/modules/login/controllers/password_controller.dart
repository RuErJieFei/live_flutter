import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/base_extend.dart';
import 'package:wit_niit/app/modules/login/views/reset_password_page.dart';
import 'package:wit_niit/app/routes/app_pages.dart';
import 'package:wit_niit/main.dart';

/// 创建时间：2022/11/19
/// 作者：w2gd

class PasswordController extends GetxController {
  TextEditingController phoneTf = TextEditingController();
  TextEditingController vCodeTf = TextEditingController();
  TextEditingController passwordTf = TextEditingController();
  TextEditingController rePasswordTf = TextEditingController();

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
    Get.to(() => ResetPasswordPage());
  }

  /// 重置密码
  resetPassword() async {
    if (!BaseExtend.isValue(passwordTf.text)) {
      EasyLoading.showToast('请输入新密码');
      return;
    } else if (passwordTf.text.length < 6) {
      EasyLoading.showToast('密码不能少于6位');
      return;
    } else if (passwordTf.text != rePasswordTf.text) {
      EasyLoading.showToast('两次密码输入不一致');
      return;
    }
    var dataForm = {
      "phone": phoneTf.text,
      "code": vCodeTf.text,
      "password": passwordTf.text,
    };
    request.post('/users/resetPwd', data: dataForm).then((value) {
      LogUtil.v('返回》》》》 $value');
      EasyLoading.showSuccess('修改成功');
      Get.offAllNamed(Routes.LOGIN);
    }).catchError((_) {
      EasyLoading.showError('修改失败，请重试');
      vCodeTf.text = '';
      Get.back();
    });
  }
}
