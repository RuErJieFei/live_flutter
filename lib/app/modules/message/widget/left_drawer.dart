// ignore_for_file: prefer_const_constructors
import 'package:authing_sdk/client.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

/// 创建时间：2022/11/8
/// 作者：w2gd
/// 描述：左侧抽屉

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('${SpUtil.getString('avatar')}'),
            ),
            accountName: Text('${SpUtil.getString('username')}'),
            accountEmail: Text('${SpUtil.getString('email')}'),
          ),
          SizedBox(height: 70.h),
          ListTile(leading: Text('手机号'), title: Text('${SpUtil.getString('phone')}')),
          ListTile(leading: Text('邮箱'), title: Text('${SpUtil.getString('email')}')),
          ElevatedButton(
            onPressed: () {
              SpUtil.clear();
              AuthClient.logout();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Text('退出登录'),
          ),
        ],
      ),
    );
  }
}
