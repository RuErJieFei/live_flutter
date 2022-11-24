import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_write_controller.dart';

class SurveyWriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyWriteController>(
      () => SurveyWriteController(),
    );
  }
}
