import 'package:authing_sdk/client.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_controller.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseData.kBackColor,
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
      ),
      body: //通过ConstrainedBox来确保Stack占满屏幕
          ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Obx(() {
              return ListView.separated(
                itemCount: controller.settingList.length,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  if (index == 0 || index == 5) {
                    return Divider(
                      thickness: 10,
                      color: BaseData.kBackColor,
                    );
                  } else if (index == 1 || index == 2) {
                    return Container();
                  } else {
                    return Divider(
                      indent: 15,
                      endIndent: 15,
                      height: 1,
                    );
                  }
                },
                itemBuilder: (BuildContext context, int index) {
                  return itemBuild(context, index);
                },
              );
            }),
            Positioned(
              bottom: Get.height / 12,
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    SpUtil.clear();
                    AuthClient.logout();
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Container(
                    child: Text(
                      '退出登录',
                      textAlign: TextAlign.center,
                    ),
                    width: Get.width,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    if (index == 2) {
      return Container(
        color: BaseData.kBackColor,
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 0, 10.h),
        child: Text(
          '通用',
          style: BaseStyle.grayContentStyle,
        ),
      );
    }
    return SettingItem(
      index: index,
      personalInfo: controller.settingList[index],
    );
  }
}

class SettingItem extends GetView<SettingController> {
  const SettingItem({Key? key, required this.index, required this.personalInfo})
      : super(key: key);

  final int index;
  final PersonalInfo personalInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget infoText = Text(personalInfo.content ?? '');
    Widget arrow = Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16,
    );
    children.add(infoText);
    children.add(arrow);
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: personalInfo.onPress,
        leading: Text(
          personalInfo.label,
        ),
        trailing: Wrap(
          spacing: 5.w,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
