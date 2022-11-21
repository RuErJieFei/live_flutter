import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_language_controller.dart';

class SettingLanguageView extends GetView<SettingLanguageController> {
  const SettingLanguageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('多语言'),
        centerTitle: true,
      ),
      body: Container(child: Obx(() {
        return ListView.builder(
            itemCount: controller.languageList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(controller.languageList[index].genderName),
                trailing: controller.languageList[index].isSelect == true
                    ? Icon(Icons.check)
                    : Container(
                        width: 1.w,
                      ),
                onTap: () =>
                    controller.changeGender(controller.languageList[index]),
              );
            });
      })),
    );
  }
}
