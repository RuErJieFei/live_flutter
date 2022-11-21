import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_about_controller.dart';

class SettingAboutView extends GetView<SettingAboutController> {
  const SettingAboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('关于智慧南工'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 应用图标
          Container(
            padding: EdgeInsets.only(top: 150.h),
            child: Icon(
              Icons.home,
              size: 150,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text('智慧南工v1.0'),
          ),
          Container(
            margin: EdgeInsets.only(top: 50.h),
            color: Colors.white,
            child: ListTile(
              leading: Text('检查更新'),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
