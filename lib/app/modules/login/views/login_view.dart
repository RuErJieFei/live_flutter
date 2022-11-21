import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_container.dart';
import 'package:wit_niit/app/component/bg_gradinent.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/login/bindings/password_binding.dart';
import 'package:wit_niit/app/modules/login/controllers/login_controller.dart';
import 'package:wit_niit/app/modules/login/views/forgot_password_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BGContainer(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Image.asset('images/login/wit_niit_bg.png', fit: BoxFit.fill),
            ),
            Positioned(
              top: 160.h,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: controller.value,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(180),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///密码/验证码
                          Obx(() {
                            return _passwordOrSmS(context);
                          }),

                          ///输入账号/手机号
                          Obx(() {
                            return (controller.loginType == 0) ? _accountWidget() : _phoneWidget();
                          }),

                          ///输入密码
                          Obx(() {
                            return (controller.loginType == 0) ? _passwordWidget() : _vCodeWidget();
                          }),

                          ///忘记密码
                          Obx(() {
                            return (controller.loginType == 0)
                                ? _forgotPasswordWidget()
                                : SizedBox(height: 20);
                          }),

                          ///登录
                          SizedBox(height: 20),
                          MyButton(onTap: () => controller.requestLogin(), title: '登录')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///密码与短信
  Widget _passwordOrSmS(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (controller.loginType != 0) {
                LogUtil.v('切换密码登录');
                //关闭键盘
                FocusScope.of(context).requestFocus(FocusNode());
                // 切换登录方式
                controller.loginType.value = 0;
              }
            },
            child: Text(
              '密码登录',
              style: TextStyle(
                color: (controller.loginType == 0) ? Config.mainColor : Colors.grey,
                fontSize: (controller.loginType == 0) ? 20.sp : 16.sp,
                fontWeight: (controller.loginType == 0) ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 13.5.w, right: 13.5.w),
            width: 1,
            height: 21.5.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFBFBFBF), Color(0xFFA5A5A5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (controller.loginType != 1) {
                LogUtil.v('切换验证码登录');
                // 关闭键盘,切换登录方式
                FocusScope.of(context).requestFocus(FocusNode());
                controller.loginType.value = 1;
              }
            },
            child: Text(
              '验证码登录',
              style: TextStyle(
                color: (controller.loginType == 1) ? Config.mainColor : Colors.grey,
                fontSize: (controller.loginType == 1) ? 20.sp : 16.sp,
                fontWeight: (controller.loginType == 1) ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///输入账号
  Widget _accountWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 26.h),
      child: TextField(
        keyboardAppearance: Brightness.light,
        controller: controller.accountTf,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          prefixIcon: Icon(Icons.person),
          hintText: '请输入账号',
          labelStyle:
              TextStyle(color: Color(0xFFA5A5A5), fontSize: 14.sp, fontWeight: FontWeight.w400),
          hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        // keyboardType: TextInputType.multiline,
      ),
    );
  }

  /// 输入手机号
  Widget _phoneWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 26.h),
      child: TextField(
        keyboardAppearance: Brightness.light,
        controller: controller.phoneTf,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          LengthLimitingTextInputFormatter(11),
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          prefixIcon: Icon(Icons.phone_android),
          hintText: '请输入手机号',
        ),
        // keyboardType: TextInputType.multiline,
      ),
    );
  }

  /// 输入密码
  Widget _passwordWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 20.h),
      child: TextField(
        keyboardAppearance: Brightness.light,
        controller: controller.passwordTf,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
          ),
          prefixIcon: Icon(Icons.lock),
          hintText: '请输入密码',
        ),
      ),
    );
  }

  ///输入验证码+验证码
  Widget _vCodeWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          SizedBox(
            width: 190.w,
            child: TextField(
              keyboardAppearance: Brightness.light,
              controller: controller.vCodeTf,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
                ),
                prefixIcon: Icon(Icons.verified_user),
                hintText: '请输入验证码',
              ),
            ),
          ),
          Expanded(child: SizedBox()),

          ///获取验证码
          InkWell(
            onTap: () => controller.getVCode(),
            child: BGGradient(
              alignment: Alignment.center,
              height: 48.h,
              width: 110.w,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Text(
                controller.vCodeStr.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///忘记密码
  _forgotPasswordWidget() {
    return InkWell(
      onTap: () {
        Get.to(ForgotPasswordView(), binding: PasswordBinding());
      },
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(top: 10.h),
        child: Text(
          '忘记密码？',
          style: TextStyle(color: Colors.grey, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
