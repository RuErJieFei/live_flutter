import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/private_chat_record.dart';
import 'package:wit_niit/app/modules/message/widget/my_message_tile.dart';
import 'package:wit_niit/main.dart';

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
  // DateBar(lable: 'Yesterday');

  //TODO: 通信
  // var channel;
  // void chat() async {
  //   LogUtil.v('创建一个WebSocketChannel连接到一台服务器');
  //   var id = SpUtil.getString('userId');
  //   // channel = IOWebSocketChannel.connect(Uri.parse('${NetUrl.socket_HostName}$id'));
  //   channel = IOWebSocketChannel.connect(Uri.parse('wss://6007j505z7.oicp.vip/websocket/$id'));
  //   LogUtil.v('连接完成～～');
  //   channel.stream.listen((msg) {
  //     LogUtil.v('监听消息 ～～$msg');
  //     var now = new DateTime.now();
  //     channel.sink.add('received!');
  //     msgList.add(
  //       MessageTile(
  //         message: msg,
  //         messageDate: "${now.hour}:${now.minute}",
  //       ),
  //     );
  //   });
  // }

  /// 滚动到底部
  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getSingleHistory(Get.find<MessageController>().currentFriendId); // 获取聊天记录
  }

  @override
  void onReady() {
    super.onReady();
    scroll.jumpTo(scroll.position.maxScrollExtent); // 滚动到底部
  }

  @override
  void onClose() {
    super.onClose();
  }

  //TODO: 发送文字消息
  void sendMsg(id) async {
    LogUtil.v('联系人id: $id');
    if (msgTf.text.length != 0) {
      LogUtil.v('发送消息～～');
      var dataForm = {
        "msg": msgTf.text,
        "userId": id,
        "fromId": SpUtil.getString('userId'),
      };
      request.post('${NetUrl.msg_HostName}/ws/sendsingle', data: dataForm).then((value) {
        LogUtil.v('发送消息返回 $value');
      });

      var now = new DateTime.now();
      msgList.add(
        MessageOwnTile(
          messageDate: "${now.hour}:${now.minute}",
          widget: TextMsg(message: msgTf.text),
        ),
      );
      // 滚动到底部、输入清空
      scrollToBottom();
      msgTf.text = '';
      hasContent.value = false;
    }
  }

  //TODO 发送图片消息
  void sendImageMsg() async {
    EasyLoading.showToast('选择图片');
    List<Media>? res = await ImagesPicker.pick(count: 1, pickType: PickType.image);
    if (res != null) {
      var path = res[0].path; // 本地图片地址
      LogUtil.v(path);
      var now = new DateTime.now();
      msgList.add(
        MessageOwnTile(
          messageDate: "${now.hour}:${now.minute}",
          widget: ImgFileMsg(filepath: path),
        ),
      );
    }
    scrollToBottom();
  }

  /// 获取私聊记录： 1是私聊，2是群聊
  /// type: 1是文字，2是文件
  void getSingleHistory(toId) async {
    String? myId = SpUtil.getString('userId');
    List chatList = await request.get('${NetUrl.msg_HostName}/ws/singlehistory/$myId&$toId');
    // 聊天记录渲染
    chatList.forEach((e) {
      PrivateChatRecord record = PrivateChatRecord.fromJson(e);
      // 我发送给对方的消息
      if (myId == record.fromId) {
        // 文字消息
        if (record.type == 1) {
          msgList.add(
            MessageOwnTile(
              messageDate: record.createTime,
              widget: TextMsg(message: record.content),
            ),
          );
        }
      } else if (toId == record.fromId) {
        if (record.type == 1) {
          msgList.add(
            MessageTile(
              messageDate: record.createTime,
              widget: TextMsg(message: record.content),
            ),
          );
        }
      }
    });
  }
}
