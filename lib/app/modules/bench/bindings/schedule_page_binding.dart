import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_page_controller.dart';

class SchedulePageBingding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
  }

}