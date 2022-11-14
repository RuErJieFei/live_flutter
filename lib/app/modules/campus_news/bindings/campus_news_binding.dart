import 'package:get/get.dart';

import '../controllers/campus_news_controller.dart';

class CampusNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CampusNewsController>(
      () => CampusNewsController(),
    );
  }
}
