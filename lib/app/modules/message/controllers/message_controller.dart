import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wit_niit/app/data/helpers.dart';
import 'package:wit_niit/app/modules/message/model/message_model.dart';

class MessageController extends GetxController {
  /// 最新消息列表
  var messageList = [].obs;

  /// 添加一条记录到消息列表
  void addMessage() {
    final Faker faker = Faker(); // 假数据
    final date = Helpers.randomDate();
    MessageData data = MessageData(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: Jiffy(date).fromNow(),
      profilePicture: Helpers.randomPictureUrl(),
    );
    messageList.add(data);
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化消息列表
    for (int i = 1; i <= 4; i++) {
      addMessage();
    }
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
