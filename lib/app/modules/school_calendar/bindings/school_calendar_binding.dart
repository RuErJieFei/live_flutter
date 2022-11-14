import 'package:get/get.dart';

import '../controllers/school_calendar_controller.dart';

class SchoolCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolCalendarController>(
      () => SchoolCalendarController(),
    );
  }
}
