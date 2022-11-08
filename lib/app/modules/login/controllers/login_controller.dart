import 'dart:io';

import 'package:authing_sdk/client.dart';
import 'package:authing_sdk/result.dart';
import 'package:authing_sdk/user.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/base_extend.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: 文本输入框控制器
  late final SystemUiOverlayStyle value;
  TextEditingController accountTf = TextEditingController();
  TextEditingController phoneTf = TextEditingController();
  TextEditingController passwordTf = TextEditingController();
  TextEditingController vCodeTf = TextEditingController();

  // 登录方式 0：密码 1：短信
  var loginType = 1.obs;
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
    accountTf.text = '17314433312';
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
  getVCode() async {
    if (phoneTf.text.length != 11) {
      EasyLoading.showToast('请输入正确的手机号');
      return;
    }
    if (!sendCodeBtn) {
      LogUtil.v('获取验证码~~');
      startTimer();
      AuthResult result = await AuthClient.sendSms(phoneTf.text, "+86");

      // request.post(NetUrl.user_vCode);
    }
  }

  /// 请求登录
  void requestLogin() async {
    // var params = Map<String, Object>();
    AuthResult result;
    if (loginType == 0) {
      if (!BaseExtend.isValue(accountTf.text)) {
        EasyLoading.showToast('请输入账号');
        return;
      }
      if (!BaseExtend.isValue(passwordTf.text)) {
        EasyLoading.showToast('请输入密码');
        return;
      }

      /// Authing 账户登录，可以是手机号 / 邮箱 / 用户名
      result = await AuthClient.loginByAccount(accountTf.text, passwordTf.text);
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

      /// Authing 手机验证码登录/注册
      result = await AuthClient.loginByPhoneCode(phoneTf.text, vCodeTf.text);
    }
    if (result.code != 200) {
      EasyLoading.showError(result.message);
      return;
    }
    User? user = result.user;
    LogUtil.v('登录成功！！！${user?.token}');
    SpUtil.putString('token', user!.token);
    SpUtil.putString('username', user.name);
    SpUtil.putString('email', user.email);
    SpUtil.putString('avatar', user.photo);
    SpUtil.putString('phone', user.phone);

    Get.offAllNamed(Routes.INDEX);
    // request.post(NetUrl.user_login).then((value) {
    //   ///  存储用户信息和token
    //   ///  跳转到首页，取消之前所有路由
    //   Get.offAllNamed(Routes.INDEX);
    // }).catchError((_) {});
  }

  /// Authing 邮箱注册
  void authingRegister() async {
    String email = accountTf.text;
    String password = passwordTf.text;
    AuthResult result = await AuthClient.registerByEmail(email, password);
    LogUtil.v('返回用户信息：${result.user?.email}');
  }

  ///  Authing 获取当前登录用户信息
  void getUserInfo() async {
    AuthResult result = await AuthClient.getCurrentUser();
    User? user = result.user; // user info
    LogUtil.v('返回 头像>>>${result.user?.photo}');
  }
}
