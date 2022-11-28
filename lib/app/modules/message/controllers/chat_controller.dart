import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';

/// 创建时间：2022/11/9
/// 作者：w2gd
/// 描述：

class ChatController extends GetxController {
  // 判断输入框是否有内容
  var hasContent = false.obs;
  // 是否隐藏底部菜单
  var hiddenMenu = true.obs;
  // 是否隐藏 emoji 选择器
  var hiddenEmoji = true.obs;
  // 输入框控制器
  TextEditingController msgTf = TextEditingController();
  // 滚动控制器
  ScrollController scroll = ScrollController();
  // 消息列表
  var msgList = <Widget>[].obs;
  var msgCto = Get.find<MessageController>();

  // Todo: 滚动到底部
  // void scrollToBottom() {
  //   Future.delayed(Duration(milliseconds: 300), () {
  //     if (scroll.hasClients) {
  //       scroll.animateTo(scroll.position.maxScrollExtent,
  //           duration: Duration(milliseconds: 300), curve: Curves.linear);
  //     }
  //   });
  // }

  // Todo: 获取聊天记录
  void getChatRecord(Conversation conversation) async {
    // limit 取值范围 1~100，如调用 queryMessage 时不带 limit 参数，默认获取 20 条消息记录
    try {
      List<Message> messages = await conversation.queryMessage(limit: 50);
      String? myId = SpUtil.getString('userId');
      List<Widget> list = messages
          .map((e) {
        if (myId == e.fromClientID) {
          /// 文字消息
          return msgCto.getMyMsgWidget(e);
        } else {
          return msgCto.getMsgWidget(e);
        }
      })
          .cast<Widget>()
          .toList();
      msgCto.recordList.assignAll(list.reversed);
      // scrollToBottom(); // 滚动到底部
      conversation.read(); // 清空未读消息数
    } catch (e) {
      LogUtil.v(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    msgCto.recordList.clear(); // 清空上一个会话的聊天记录
  }

  @override
  void onReady() {
    super.onReady();
    getChatRecord(msgCto.currentConv);
    // 每次监听到变化都回调
    ever(msgCto.msgCount, (callback) {
      // scrollToBottom();
      msgCto.currentConv.read();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  //TODO: 向会话发送文字消息
  void sendMsg(Conversation conversation) async {
    if (msgTf.text.length != 0) {
      try {
        TextMessage textMessage = TextMessage();
        textMessage.text = msgTf.text;
        // 向对话中发送一条消息
        await conversation.send(message: textMessage);
        var msg = msgCto.getMyMsgWidget(textMessage);
        // msgCto.recordList.add(msg);
        msgCto.recordList.insert(0, msg);
        // 滚动到底部、输入清空
        // scrollToBottom();
        msgTf.clear();
        hasContent.value = false;
      } catch (e) {
        EasyLoading.showError('发送失败$e');
      }
      return;
    }
  }

  //TODO 向会话发送图片消息
  void sendImageMsg(Conversation conversation) async {
    List<Media>? res = await ImagesPicker.pick(count: 1, pickType: PickType.image);
    if (res != null) {
      String path = res[0].path; // 本地图片地址
      LogUtil.v(path);
      // 显示在聊天框
      ByteData imageData = await rootBundle.load(path);
      ImageMessage imageMessage = ImageMessage.from(
        binaryData: imageData.buffer.asUint8List(),
        format: path.split('.').last,
        name: 'niit',
      );
      var msg = msgCto.getMyMsgWidget(imageMessage, path: path, imageType: 0);
      // msgCto.recordList.add(msg);
      msgCto.recordList.insert(0, msg);
      // scrollToBottom();
      // 发送给云服务
      try {
        conversation.send(message: imageMessage);
      } catch (e) {
        EasyLoading.showError('图片发送失败');
      }
    }
  }
}
