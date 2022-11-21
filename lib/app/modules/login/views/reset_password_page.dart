// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/modules/login/controllers/password_controller.dart';

/// 创建时间：2022/11/19
/// 作者：w2gd
/// 描述：reset_password_page

class ResetPasswordPage extends GetView<PasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('重置密码'),
      ),
      body: Container(
        color: Color(0xffeeeeee),
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          children: [
            /// 登录密码
            _passwordWidget(controller.passwordTf, '登录密码', '请输入密码'),

            /// 确认密码
            _passwordWidget(controller.rePasswordTf, '确认密码', '再次输入密码'),

            /// 确认重置
            SizedBox(height: 30),
            MyButton(
              onTap: () => controller.resetPassword(),
              title: '重置密码',
            )
          ],
        ),
      ),
    );
  }

  Widget _passwordWidget(TextEditingController TfController, String title, String hint) {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(top: 26.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          Expanded(
            child: TextField(
              keyboardAppearance: Brightness.light,
              controller: TfController,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
