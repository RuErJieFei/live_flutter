import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
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
  ScrollController scrollCto = ScrollController();
  // 消息列表
  var msgList = <Widget>[].obs;
  var msgCto = Get.find<MessageController>();
  // 会话名称
  var ConvName = ''.obs;

  // Todo: 滚动到底部
  // void scrollToBottom() {
  //   Future.delayed(Duration(milliseconds: 300), () {
  //     if (scroll.hasClients) {
  //       scroll.animateTo(scroll.position.maxScrollExtent,
  //           duration: Duration(milliseconds: 300), curve: Curves.linear);
  //     }
  //   });
  // }
  /// 聊天记录：
  late List<Message> messages;

  // Todo: 获取聊天记录
  void getChatRecord(Conversation conversation) async {
    LogUtil.v('获取 【${conversation.name}】 的聊天记录');
    // limit 取值范围 1~100，如调用 queryMessage 时不带 limit 参数，默认获取 20 条消息记录
    try {
      messages = await conversation.queryMessage(limit: 15);
      String? myId = SpUtil.getString('userId');
      List<Widget> list = messages
          .map((e) {
            if (myId == e.fromClientID) {
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
      EasyLoading.showToast('状态异常，请重启应用');
      // msgCto.onReady();
    }
  }

  @override
  void onInit() {
    super.onInit();
    msgCto.recordList.clear(); // 清空上一个会话的聊天记录
  }

  @override
  void onClose() {
    // scrollCto.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    getChatRecord(msgCto.currentConv);

    /// 每次监听到消息都回调
    ever(msgCto.msgCount, (callback) {
      // scrollToBottom();
      msgCto.currentConv.read();
    });

    /// 滚动监听
    scrollCto.addListener(() {
      if (isLoading) {
        return;
      }
      if (scrollCto.offset > scrollCto.position.maxScrollExtent + 100) {
        onLoadingMsg();
      }
    });

    /// 播放声音完成的监听监听
    msgCto.recordPlugin.responsePlayStateController.listen((data) {
      print("播放路径   " + data.playPath);
      print("播放状态   " + data.playState);
    });
  }

  // todo: 下拉加载历史消息
  // 加载状态
  bool isLoading = false;
  void onLoadingMsg() async {
    isLoading = true;
    // 返回的消息一定是时间增序排列，也就是最早的消息一定是第一个
    Message oldMessage = messages.first;
    // 以第一页的最早的消息作为开始，继续向前拉取消息
    List<Message> newMessages = await msgCto.currentConv.queryMessage(
      startTimestamp: oldMessage.sentTimestamp,
      startMessageID: oldMessage.id,
      startClosed: true,
      limit: 7,
    );
    newMessages.removeLast();
    if (newMessages.length == 0) {
      scrollCto.dispose();
      EasyLoading.showToast('已加载全部消息');
      return;
    }
    messages.insertAll(0, newMessages);
    // 渲染到聊天记录
    String? myId = SpUtil.getString('userId');
    List<Widget> list = newMessages
        .map((e) {
          if (myId == e.fromClientID) {
            return msgCto.getMyMsgWidget(e);
          } else {
            return msgCto.getMsgWidget(e);
          }
        })
        .cast<Widget>()
        .toList();
    msgCto.recordList.addAll(list.reversed);
    await Future.delayed(Duration(seconds: 1), () => isLoading = false);
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
      // 显示在聊天框
      ImageMessage imageMessage = ImageMessage.from(
        binaryData: await File(path).readAsBytes(),
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

  // Todo: 发送音频消息
  void sendAudioMessage(Conversation conv, String filePath) async {
    AudioMessage audioMessage = AudioMessage.from(
      binaryData: await File(filePath).readAsBytes(),
      format: filePath.split('.').last,
    );
    try {
      Message message = await conv.send(message: audioMessage);
      if (message is AudioMessage) {
        var msg = msgCto.getMyMsgWidget(message);
        msgCto.recordList.insert(0, msg);
      }
    } catch (e) {
      EasyLoading.showError('发送语音失败');
    }
  }

  // Todo: 添加他人加入会话
  void addMembers(String convId, Set<String> friendsSet) async {
    List<Conversation> conversations;
    try {
      // 首先根据 ID 获取 Conversation 实例
      ConversationQuery query = msgCto.me.conversationQuery();
      query.whereEqualTo('objectId', convId);
      conversations = await query.find();
      Conversation conversation = conversations.first;
      // 邀请他人加入对话
      MemberResult addResult = await conversation.addMembers(
        members: friendsSet,
      );
    } catch (e) {
      LogUtil.v('添加失败');
    }
  }

  // Todo: 将他人踢出会话
  void removeMember(Conversation conv, String id) {
    conv.removeMembers(members: {id});
  }

  // todo : 退出群聊
  void quitGroup(Conversation conv) {
    conv.quit();
  }

  // todo: 修改群聊名称
  Future<bool> updateGroupName(Conversation conv, String name) async {
    if (name.trim().isEmpty) {
      EasyLoading.showToast('群名称不能为空');
      return false;
    }
    try {
      await conv.updateInfo(attributes: {
        'name': name,
      });
      return true;
    } catch (e) {
      EasyLoading.showError('网络异常，修改失败');
      return false;
    }
  }
}
