import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_phone_controller.dart';

class PersonalPhoneView extends GetView<PersonalPhoneController> {
  const PersonalPhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Scaffold(
      appBar: AppBar(
        title: const Text('手机号'),
        centerTitle: true,
      ),
      //通过ConstrainedBox来确保Stack占满屏幕
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 150,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h), child: Text('当前手机号')),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      '${user?.phone}',
                      style: BaseStyle.contentStyle.copyWith(fontSize: 32.sp),
                    ),
                  ),
                  Text(
                    '此手机号将显示在个人信息中，\n你也可以使用此手机号登录。',
                    textAlign: TextAlign.center,
                    style: BaseStyle.graySmallStyle,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 166.h,
              child: TextButton(
                onPressed: () => LogUtil.v('更换手机号'),
                child: Container(
                  // color: Config.mainColor.withOpacity(0.1),
                  width: Get.width * 0.8,
                  height: Get.width / 10,
                  alignment: Alignment.center,
                  child: Text(
                    '更换手机号',
                    textAlign: TextAlign.center,
                    style: BaseStyle.topStyle.copyWith(color: Config.mainColor),
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Config.mainColor.withOpacity(0.07),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
