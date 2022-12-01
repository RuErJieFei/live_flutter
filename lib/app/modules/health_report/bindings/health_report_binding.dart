import 'package:get/get.dart';

import '../controllers/health_report_controller.dart';
import '../controllers/health_table_controller.dart';

class HealthReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthReportController>(
      () => HealthReportController(),
    );

    Get.lazyPut<HealthTableController>(
      () => HealthTableController(),
    );
  }
}
