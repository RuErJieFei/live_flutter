import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_account_controller.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';

class SettingAccountView extends GetView<SettingAccountController> {
  const SettingAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BaseData.kBackColor,
        appBar: AppBar(
          title: const Text('账号与安全'),
          centerTitle: true,
        ),
        body: Obx(() {
          return ListView.separated(
            itemCount: controller.accountList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                indent: 15,
                endIndent: 15,
                height: 1,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return itemBuild(context, index);
            },
          );
        }));
  }

  Widget itemBuild(BuildContext context, int index) {
    return PersonalInfoItem(
      index: index,
      personalInfo: controller.accountList[index],
    );
  }
}

class PersonalInfoItem extends GetView<SettingAccountController> {
  const PersonalInfoItem(
      {Key? key, required this.index, required this.personalInfo})
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
          )),
    );
  }
}
