import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_gradinent.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/modules/login/controllers/password_controller.dart';

class ForgotPasswordView extends GetView<PasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('忘记密码'),
      ),
      body: Container(
        color: Color(0xffeeeeee),
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          children: [
            /// 输入手机号
            _phoneWidget(),

            /// 输入验证码
            _vCodeWidget(),

            /// 下一步
            SizedBox(height: 30),
            MyButton(
              onTap: () => controller.verification(),
              title: '下一步',
            )
          ],
        ),
      ),
    );
  }

  /// 输入手机号
  Widget _phoneWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 26.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
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
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(Icons.phone_android),
          hintText: '请输入手机号',
        ),
      ),
    );
  }

  /// 验证码
  Widget _vCodeWidget() {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
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
                border: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.verified_user),
                hintText: '请输入验证码',
              ),
            ),
          ),
          Expanded(child: SizedBox()),

          ///获取验证码
          InkWell(
            onTap: () => controller.getVCode(),
            child: Obx(() {
              return BGGradient(
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
              );
            }),
          )
        ],
      ),
    );
  }
}
