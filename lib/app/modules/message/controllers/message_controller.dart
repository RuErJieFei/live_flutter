import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/model/message_model.dart';
import 'package:wit_niit/main.dart';

class MessageController extends GetxController {
  /// 最新消息列表
  var messageList = <MessageData>[].obs;

  //TODO: 通信
  var channel;
  void linkSocket() async {
    LogUtil.v('创建一个WebSocketChannel连接到一台服务器');
    var id = SpUtil.getString('userId');
    channel = IOWebSocketChannel.connect(Uri.parse('${NetUrl.socket_HostName}$id'));
    LogUtil.v('连接完成～～');
    channel.stream.listen((msg) {
      LogUtil.v('监听消息 ～～$msg');
      channel.sink.add('received!');
    });
  }

  /// 添加一条记录到消息列表
  void addMessage(MessageData data) {
    messageList.add(data);
  }

  @override
  void onInit() {
    super.onInit();
    getContacts(); // 获取通讯录
    // 初始化消息列表
    // for (int i = 1; i <= 4; i++) {
    //   addMessage();
    // }
  }

  @override
  void onReady() {
    super.onReady();
    linkSocket(); // 连接web_socket
  }

  @override
  void onClose() {
    channel.sink.close(); // 关闭连接
    super.onClose();
  }

  /// 联系人列表
  var contactList = <ContactModel>[].obs;

  /// 获取 Authing 用户池列表
  void getContacts() async {
    Map<String, dynamic> params = {"page": 1, "limit": 50};
    List res = await request.get('/users/userlist', params: params);
    res.forEach((e) {
      ContactModel contact = ContactModel.fromJson(e);
      contactList.add(contact);
    });
  }
}
