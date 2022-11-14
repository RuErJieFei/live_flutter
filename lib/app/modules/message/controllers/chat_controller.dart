import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

/// 创建时间：2022/11/9
/// 作者：w2gd
/// 描述：

class ChatController extends GetxController {
  //TODO: 通信
  void chat() async {
    var channel = IOWebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
    channel.stream.listen((msg) {
      channel.sink.add('received!');
      channel.sink.close(status.goingAway); // 消息关闭
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
