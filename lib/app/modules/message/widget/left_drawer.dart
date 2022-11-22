// ignore_for_file: prefer_const_constructors
import 'package:authing_sdk/client.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/bindings/setting_binding.dart';
import 'package:wit_niit/app/modules/personal/views/personal_view.dart';
import 'package:wit_niit/app/modules/personal/views/setting_view.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

/// 创建时间：2022/11/8
/// 作者：w2gd
/// 描述：左侧抽屉

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj("user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
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
                backgroundImage: AssetImage('images/public/emoji.png'),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const _BottomSheet(), transition: Transition.downToUp);
                },
                child: Image.asset('images/public/qrcode.png'),
              ),
            ],
            accountName: Text(
              '${user?.name}',
              style: TextStyle(fontSize: 20.sp),
            ),
            accountEmail: Text('${user?.email}'),
            onDetailsPressed: () {
              // 先返回一层 关闭掉 drawer
              // 这样返回时 drawer 就是已经关闭的了
              Get.back();
              Get.to(() => PersonalView());
            },
          ),
          ListTile(
              title: Text(
            '${user?.roleList?[0]}', // 角色
            style: TextStyle(fontSize: 20.sp),
          )),
          ListTile(leading: new Icon(Icons.help), title: new Text("帮助")),
          ListTile(
            leading: new Icon(Icons.settings),
            title: new Text("设置"),
            onTap: () {
              Get.back();
              Get.to(() => SettingView(), binding: SettingBinding());
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

/// 展示二维码
class _BottomSheet extends StatelessWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
      "user",
      (v) => UserModel.fromJson(v as Map<String, dynamic>),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_downward_outlined),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('对外名片'),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 0.6 * MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(15),
                child: LayoutBuilder(builder: (_, zone) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Image.network(
                              '${user?.photo}',
                              fit: BoxFit.cover,
                            ),
                            alignment: Alignment.centerLeft,
                            height: zone.maxHeight / 3,
                            padding: EdgeInsets.only(right: 20),
                          ),
                          Text(
                            '${user?.name}',
                            style: TextStyle(fontSize: 25.sp),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: QrImage(
                            data: '${user?.id}',
                            version: QrVersions.auto,
                            embeddedImage: AssetImage('images/public/emoji.png'),
                            foregroundColor: Config.mainColor,
                          ),
                          padding: EdgeInsets.all(20),
                        ),
                      )
                    ],
                  );
                }),

                // Column(
                //   children: [
                //
                //
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
