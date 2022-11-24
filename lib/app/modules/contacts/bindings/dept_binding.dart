import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:wit_niit/app/modules/contacts/controllers/dept_controller.dart';

class DeptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeptController>(() => DeptController());
  }
}
