import 'package:get/get.dart';

import '../controllers/bench_controller.dart';

class BenchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BenchController>(
      () => BenchController(),
    );
  }
}
