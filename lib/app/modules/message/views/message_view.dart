import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/index/controllers/index_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/views/message_page.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var indexC = Get.find<IndexController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('消息'),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(icon: Icon(Icons.menu), onPressed: () => indexC.open());
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined, size: 30),
            onPressed: () => Get.toNamed('/message/search'),
          ),
          SizedBox(width: 10),
          _popupMenu(),
          SizedBox(width: 15),
        ],
      ),
      body: MessagesPage(),
    );
  }

  /// + 号 菜单
  Widget _popupMenu() {
    return PopupMenuButton(
      offset: Offset(0, 50),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(20),
        ),
      ),
      onSelected: (v) {
        if (v == '发起群聊') {
          EasyLoading.showToast('发起群聊');
        } else if (v == '加微信') {
          EasyLoading.showToast('加微信');
        } else if (v == '扫一扫') {
          EasyLoading.showToast('扫一扫');
        } else if (v == '休息一下') {
          EasyLoading.showToast('休息一下');
        }
      },
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '发起群聊',
            child: Wrap(
              spacing: 10,
              children: [
                Icon(Icons.message, color: Config.mainColor),
                Text('发起群聊', style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: '加微信',
            child: Wrap(
              spacing: 10,
              children: [
                Icon(Icons.wechat, color: Config.mainColor),
                Text('加微信', style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: '扫一扫',
            child: Wrap(
              spacing: 10,
              children: [
                Icon(Icons.qr_code_scanner, color: Config.mainColor),
                Text('扫一扫', style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: '休息一下',
            child: Wrap(
              spacing: 10,
              children: [
                Icon(Icons.coffee, color: Config.mainColor),
                Text('休息一下', style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
              ],
            ),
          ),
        ];
      },
      child: Icon(Icons.add_circle_outline, size: 28),
    );
  }
}
