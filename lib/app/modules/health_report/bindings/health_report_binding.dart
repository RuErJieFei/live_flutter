import 'package:get/get.dart';

import '../controllers/health_report_controller.dart';

class HealthReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthReportController>(
      () => HealthReportController(),
    );
  }
}
