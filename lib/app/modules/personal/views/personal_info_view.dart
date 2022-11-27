import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/app/modules/personal/model/personal_info_model.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BaseData.kBackColor,
        appBar: AppBar(
          title: const Text('个人信息'),
          centerTitle: true,
          leading: BackButton(
            onPressed: () => Get.offAllNamed(Routes.PERSONAL),
          ),
        ),
        body: Obx(() {
          return ListView.separated(
            itemCount: controller.personalInfoList.length,
            separatorBuilder: (BuildContext context, int index) {
              if (index == 2 || index == 5) {
                return Divider(
                  thickness: 10,
                  color: BaseData.kBackColor,
                );
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
        }));
  }

  Widget itemBuild(BuildContext context, int index) {
    return PersonalInfoItem(
      index: index,
      personalInfo: controller.personalInfoList[index],
    );
  }
}

class PersonalInfoItem extends GetView<PersonalInfoController> {
  const PersonalInfoItem(
      {Key? key, required this.index, required this.personalInfo})
      : super(key: key);

  final int index;
  final PersonalInfo personalInfo;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        '${personalInfo.content}',
        width: 40.w,
        height: 40.w,
        fit: BoxFit.cover,
      ),
    );
    Widget company = Icon(
      Icons.check_circle_outline,
      color: Colors.green,
    );
    Widget infoText = Text(personalInfo.content ?? '');
    Widget arrow = Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16,
    );
    if (personalInfo.label == '头像') {
      children.add(avatar);
      children.add(arrow);
    } else if (personalInfo.label == '所在企业') {
      if (personalInfo.content != '暂无') {
        children.add(company);
      }
      children.add(infoText);
      children.add(arrow);
    } else if (personalInfo.label == '个人状态') {
      if (personalInfo.content == '暂无') {
        children.add(
          Text('添加个人状态...'),
        );
      } else {
        children.add(infoText);
      }
      children.add(arrow);
    } else if (personalInfo.label == '职务') {
      children.add(infoText);
    } else {
      children.add(infoText);
      children.add(arrow);
    }

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
