import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_edit_controller.dart';

class SurveyEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyEditController>(
      () => SurveyEditController(),
    );
  }
}
