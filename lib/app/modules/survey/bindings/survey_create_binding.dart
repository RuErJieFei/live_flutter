import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_create_controller.dart';

class SurveyCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyCreateController>(
      () => SurveyCreateController(),
    );
  }
}
