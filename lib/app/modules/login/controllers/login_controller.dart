import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/base_extend.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/routes/app_pages.dart';
import 'package:wit_niit/main.dart';

class LoginController extends GetxController {
  //TODO: 文本输入框控制器
  late final SystemUiOverlayStyle value;
  TextEditingController accountTf = TextEditingController();
  TextEditingController phoneTf = TextEditingController();
  TextEditingController passwordTf = TextEditingController();
  TextEditingController vCodeTf = TextEditingController();

  // 登录方式 0：密码 1：短信
  var loginType = 0.obs;
  TimerUtil? _timerUtil;
  var vCodeStr = '获取验证码'.obs;

  // 是否点击验证码
  bool sendCodeBtn = false;

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      value = const SystemUiOverlayStyle(
        // 安卓系统状态栏存在底色，所以需要加这个
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      );
    } else if (Platform.isIOS) {
      value = SystemUiOverlayStyle.dark;
    }
    accountTf.text = '17314433221';
    passwordTf.text = '123456';
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
  getVCode() {
    if (phoneTf.text.length != 11) {
      EasyLoading.showToast('请输入正确的手机号');
      return;
    }
    if (!sendCodeBtn) {
      LogUtil.v('获取验证码~~');
      startTimer();
      // request.post(NetUrl.user_vCode);
    }
  }

  /// 请求登录
  void requestLogin() async {
    // var params = Map<String, Object>();
    if (loginType == 0) {
      if (!BaseExtend.isValue(accountTf.text)) {
        EasyLoading.showToast('请输入账号');
        return;
      }
      if (!BaseExtend.isValue(passwordTf.text)) {
        EasyLoading.showToast('请输入密码');
        return;
      }
      // params['phone'] = _accountTf.text;
    } else {
      if (!BaseExtend.isValue(phoneTf.text)) {
        EasyLoading.showToast('请输入手机号');
        return;
      }
      LogUtil.v('手机号:${RegexUtil.isTel(phoneTf.text)}');
      if (phoneTf.text.length != 11) {
        EasyLoading.showToast('请正确手机号格式');
        return;
      }
      if (!BaseExtend.isValue(vCodeTf.text)) {
        EasyLoading.showToast('请输入验证码');
        return;
      }
    }

    /// mock 数据（待删除-------）
    SpUtil.putString('username', '王東');
    SpUtil.putString('token', 'abcdefghijklmnopqrstuvwxyz');

    Get.offAllNamed(Routes.INDEX);
    return;
    request.post(NetUrl.user_login).then((value) {
      ///  存储用户信息和token
      ///  跳转到首页，取消之前所有路由
      Get.offAllNamed(Routes.INDEX);
    }).catchError((_) {});
  }
}
