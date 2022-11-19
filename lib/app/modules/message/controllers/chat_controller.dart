import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
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
  // DateBar(lable: 'Yesterday'),
  // MessageTile(
  //   message: '蓝月亮!',
  //   messageDate: '12:03',
  // ),
  // MessageOwnTile(
  //   message: '加了多少水？',
  //   messageDate: '12:03',
  //   widget: TextMsg(message: '加了多少水？'),
  // ),
  // MessageOwnTile(
  //   message: '加了多少水？',
  //   messageDate: '12:03',
  //   widget: ImgMsg(imgUrl: 'http://img.w2gd.top/up/logo.png'),
  // ),

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
    // getSingleHistory(); // 获取聊天记录
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
      request.post('http://121.40.208.79:8083/ws/sendsingle', data: dataForm).then((value) {
        // https://6007j505z7.oicp.vip/ws/sendsingle'
        LogUtil.v('发送消息返回 $value');
      });

      var now = new DateTime.now();
      msgList.add(
        MessageOwnTile(
          message: msgTf.text,
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
          message: '',
          messageDate: "${now.hour}:${now.minute}",
          widget: ImgFileMsg(filepath: path),
        ),
      );
    }
    scrollToBottom();
  }

  /// 获取私聊记录
  void getSingleHistory() async {
    var data = await request.get('http://121.40.208.79:8082/ws/singlehistory/{userId}');
  }
}
