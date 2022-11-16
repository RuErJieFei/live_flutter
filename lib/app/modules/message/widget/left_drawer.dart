// ignore_for_file: prefer_const_constructors
import 'package:authing_sdk/client.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/views/personal_view.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

/// 创建时间：2022/11/8
/// 作者：w2gd
/// 描述：左侧抽屉

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage('http://img.w2gd.top/up/texture9.png'),
              fit: BoxFit.cover,
            )),
            currentAccountPicture: GestureDetector(
              onTap: () {
                // 先返回一层 关闭掉 drawer
                // 这样返回时 drawer 就是已经关闭的了
                Get.back();
                Get.to(() => PersonalView());
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage('${user?.photo}'),
              ),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    NetworkImage('http://img.w2gd.top/up/logo.png'),
              ),
            ],
            accountName: Text(
              // '${SpUtil.getString('username')}',
              '${user?.name}',
              style: TextStyle(fontSize: 20.sp),
            ),
            accountEmail: Text('${user?.email}'),
            onDetailsPressed: () {
              LogUtil.v('----');
              // 先返回一层 关闭掉 drawer
              // 这样返回时 drawer 就是已经关闭的了
              Get.back();
              Get.to(() => PersonalView());
            },
          ),
          ListTile(leading: Text('手机号'), title: Text('${user?.phone}')),
          ListTile(leading: new Icon(Icons.help), title: new Text("帮助")),
          ListTile(
            leading: new Icon(Icons.settings),
            title: new Text("设置"),
            onTap: () {
              // Get.to(()=> )
            },
          ),
          Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              SpUtil.clear();
              AuthClient.logout();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Text('退出登录'),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
