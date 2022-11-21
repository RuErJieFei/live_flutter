import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/personal/controllers/setting_message_controller.dart';

class SettingMessageView extends GetView<SettingMessageController> {
  const SettingMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息通知'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Obx(() {
              return ListTile(
                leading: Text('接收新消息通知'),
                trailing: CupertinoSwitch(
                  activeColor: Config.mainColor,
                  trackColor: Config.mainColor.withOpacity(0.3),
                  value: controller.isReceive.value,
                  onChanged: (v) => controller.changeStatus(v),
                ),
              );
            }),
            ListTile(
              onTap: () {},
              leading: Text(
                '声音',
              ),
              trailing: Wrap(
                spacing: 5.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              height: 1,
            ),
            ListTile(
              onTap: () {},
              leading: Text(
                '振动',
              ),
              trailing: Wrap(
                spacing: 5.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
