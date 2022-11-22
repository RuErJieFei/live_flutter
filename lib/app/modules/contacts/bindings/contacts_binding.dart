import 'package:flustars/flustars.dart';
import 'package:get/get.dart';

import '../controllers/contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    LogUtil.v("===================进入ContactsBinding");
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
