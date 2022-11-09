import 'package:get/get.dart';

import 'package:wit_niit/app/modules/message/controllers/search_mess_controller.dart';

import '../controllers/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMessController>(
      () => SearchMessController(),
    );
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );
  }
}
