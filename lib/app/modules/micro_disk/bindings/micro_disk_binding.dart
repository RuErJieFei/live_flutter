import 'package:get/get.dart';

import '../controllers/micro_disk_controller.dart';

class MicroDiskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MicroDiskController>(
      () => MicroDiskController(),
    );
  }
}
