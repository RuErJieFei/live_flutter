import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/index/controllers/index_controller.dart';
import 'package:wit_niit/app/modules/message/bindings/message_binding.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/views/message_page.dart';
import 'package:wit_niit/app/modules/message/views/scan_view.dart';
import 'package:wit_niit/app/modules/message/views/select_contact_view.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var indexC = Get.find<IndexController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('消息'),
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
          _popupMenu(context),
          SizedBox(width: 15),
        ],
      ),
      body: MessagesPage(),
    );
  }

  /// + 号 菜单
  Widget _popupMenu(BuildContext context) {
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
          Get.to(() => SelectContactView(), binding: MessageBinding());
        } else if (v == '添加好友') {
          controller.updateConversationList(); // 更新会话
        } else if (v == '扫一扫') {
          Get.to(() => ScanView());
          // controller.getContacts();
        } else if (v == '休息一下') {
          showDialog(context: context, builder: (_) => _haveARest());
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
            value: '添加好友',
            child: Wrap(
              spacing: 10,
              children: [
                Icon(Icons.wechat, color: Config.mainColor),
                Text('更新会话', style: TextStyle(color: Config.mainColor, fontSize: 20.sp)),
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

  /// 休息一下
  _haveARest() => UnconstrainedBox(
        child: SizedBox(
          width: 370.w,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Wrap(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.coffee, color: Config.mainColor, size: 45.w),
                    title: Text('小休'),
                    subtitle: Text('1小时内不接收消息通知'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.work_off, color: Config.mainColor, size: 45.w),
                    title: Text('下班了'),
                    subtitle: Text('明天09：00前不接受消息通知'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
