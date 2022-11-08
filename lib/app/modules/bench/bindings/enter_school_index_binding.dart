import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/enter_school_index_controller.dart';

class EnterSchoolIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterSchoolIndexController>(
      () => EnterSchoolIndexController(),
    );
  }
}
