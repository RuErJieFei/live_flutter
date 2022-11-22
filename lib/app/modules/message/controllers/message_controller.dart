import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/model/message_model.dart';
import 'package:wit_niit/app/modules/message/widget/my_message_tile.dart';
import 'package:wit_niit/main.dart';

class MessageController extends GetxController {
  /// 创建一个 Client
  Client me = Client(id: '${SpUtil.getString('userId')}');

  /// 最新消息列表
  var messageList = <MessageData>[].obs;

  /// 某个会话的聊天记录
  var recordList = <Widget>[].obs;

  // 正在私聊的对象的id
  final currentFriendId = ''.obs;

  /// 添加一条记录到消息列表
  void addMessage(MessageData data) {
    messageList.insert(0, data); // 数组头部插入数据
  }

  /// 计数： 监听到的新消息数量
  final msgCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getContacts(); // 获取通讯录
  }

  @override
  void onReady() async {
    super.onReady();
    await me.open(); // 登录LeanCloud
    me.onMessage = ({
      Client? client,
      Conversation? conversation,
      Message? message,
    }) {
      LogUtil.v('收到消息------------');
      var msg = getMsgWidget(message!);
      if (msg != null) {
        recordList.add(msg);
        msgCount.value++;
      }
      if (message is TextMessage) {
        LogUtil.v('${message.text}');
      }
    };
  }

  @override
  void onClose() {
    me.close(); // 下线
    super.onClose();
  }

  /// 联系人列表
  var contactList = <ContactModel>[].obs;

  /// 获取 Authing 用户池列表
  void getContacts() async {
    Map<String, dynamic> params = {"page": 1, "limit": 50};
    List res = await request.get('${NetUrl.user_HostName}/users/userlist', params: params);
    res.forEach((e) {
      ContactModel contact = ContactModel.fromJson(e);
      contactList.add(contact);
    });
  }

  // Todo: 返回我的消息widget
  Widget? getMyMsgWidget(Message e) {
    if (e is TextMessage) {
      return MessageOwnTile(
        messageDate: '${e.sentDate}',
        widget: TextMsg(message: '${e.text}'),
      );
    } else {
      return null;
    }
  }

  // Todo: 返回别人的消息widget
  Widget? getMsgWidget(Message e) {
    if (e is TextMessage) {
      return MessageTile(
        messageDate: '${e.sentDate}',
        widget: TextMsg(message: '${e.text}', type: 1),
      );
    } else {
      return null;
    }
  }
}
