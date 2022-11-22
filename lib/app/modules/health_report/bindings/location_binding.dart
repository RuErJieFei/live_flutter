import 'package:get/get.dart';
import 'package:wit_niit/app/modules/health_report/controllers/localtion_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(
      () => LocationController(),
    );
  }
}
