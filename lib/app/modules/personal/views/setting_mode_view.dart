import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_model_controller.dart';

class SettingModeView extends GetView<SettingModelController> {
  const SettingModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('深色模式'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Obx(() {
              return ListTile(
                leading: Text('跟随系统'),
                trailing: CupertinoSwitch(
                  activeColor: Config.mainColor,
                  trackColor: Config.mainColor.withOpacity(0.3),
                  value: controller.system.value,
                  onChanged: (v) => controller.changeSystem(v),
                ),
              );
            }),
            Obx(() {
              return Visibility(
                visible: !controller.system.value,
                child: ListTile(
                  leading: Text('深色模式'),
                  trailing: CupertinoSwitch(
                    activeColor: Config.mainColor,
                    trackColor: Config.mainColor.withOpacity(0.3),
                    value: controller.mode.value,
                    onChanged: (v) => controller.changeMode(v),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
