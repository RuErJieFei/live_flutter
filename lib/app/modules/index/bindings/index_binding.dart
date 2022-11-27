import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/bench_controller.dart';
import 'package:wit_niit/app/modules/contacts/controllers/contacts_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';

import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(() => IndexController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<BenchController>(() => BenchController());
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
