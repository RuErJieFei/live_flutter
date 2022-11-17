import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wit_niit/app/modules/message/model/chatmenu_item.dart';
import 'package:wit_niit/app/modules/message/widget/MessageTile.dart';
import 'package:wit_niit/app/modules/message/widget/date_bar.dart';
import 'package:wit_niit/app/modules/message/widget/my_message_tile.dart';

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
  var msgList = [
    DateBar(lable: 'Yesterday'),
    MessageTile(
      message: '刚刚把衣服洗了',
      messageDate: '12:01',
    ),
    MessageOwnTile(
      message: '用的洗衣粉吗？',
      messageDate: '12:02',
      widget: TextMsg(message: '加了多少水？'),
    ),
    MessageTile(
      message: '洗衣液',
      messageDate: '12:02',
    ),
    MessageOwnTile(
      message: '啥牌子的',
      messageDate: '12:03',
      widget: TextMsg(message: '加了多少水？'),
    ),
    MessageTile(
      message: '蓝月亮!',
      messageDate: '12:03',
    ),
    MessageOwnTile(
      message: '加了多少水？',
      messageDate: '12:03',
      widget: TextMsg(message: '加了多少水？'),
    ),
    MessageTile(
      message: '不晓得，洗衣机自己加的',
      messageDate: '12:03',
    ),
    MessageOwnTile(
      message: '加了多少水？',
      messageDate: '12:03',
      widget: ImgMsg(imgUrl: 'http://img.w2gd.top/up/logo.png'),
    ),
  ].obs;
  //TODO: 通信
  var channel;
  void chat() async {
    LogUtil.v('创建一个WebSocketChannel连接到一台服务器');
    channel = IOWebSocketChannel.connect(Uri.parse('ws://api.w2gd.top:6881/websocket/1'));
    // channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    LogUtil.v('连接完成～～');
    channel.stream.listen((msg) {
      LogUtil.v('监听消息 ～～');
      channel.sink.add('received!');
      // channel.sink.close(status.goingAway); // 消息关闭
    });
  }

  //TODO: 发送文字消息
  void sendMsg() async {
    // channel.sink.add('你好哇，WD');
    if (msgTf.text.length != 0) {
      LogUtil.v('发送消息～～');
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

  /// 滚动到底部
  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      scroll.animateTo(scroll.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  late List ChatMenuList;

  @override
  void onInit() {
    super.onInit();

    /// 聊天底部菜单列表
    ChatMenuList = [
      ChatMenuItem(
        title: '图片',
        imageUrl: 'images/public/picture.png',
        onTap: () {
          sendImageMsg();
        },
      ),
      ChatMenuItem(
        title: '拍摄',
        imageUrl: 'images/public/skzb.png',
        onTap: () {
          EasyLoading.showToast('拍摄视频');
        },
      ),
      ChatMenuItem(
        title: '收藏',
        imageUrl: 'images/public/xyyx.png',
        onTap: () {
          EasyLoading.showToast('分享收藏');
        },
      ),
      ChatMenuItem(
        title: '文件',
        imageUrl: 'images/public/folder.png',
        onTap: () {
          EasyLoading.showToast('分享文件');
        },
      ),
      ChatMenuItem(
        title: '图文消息',
        imageUrl: 'images/public/tw.png',
        onTap: () {
          EasyLoading.showToast('输入图文消息');
        },
      ),
      ChatMenuItem(
        title: '日程',
        imageUrl: 'images/public/xl.png',
        onTap: () {
          EasyLoading.showToast('发送日程');
        },
      ),
    ];

    /// 连接 websocket
    // chat();
  }

  @override
  void onReady() {
    super.onReady();
    scroll.jumpTo(scroll.position.maxScrollExtent); // 滚动到底部
  }

  @override
  void onClose() {
    LogUtil.v('消息关闭');
    // channel.sink.close(); // 消息关闭
    super.onClose();
  }

  /// 发送图片消息
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
}
