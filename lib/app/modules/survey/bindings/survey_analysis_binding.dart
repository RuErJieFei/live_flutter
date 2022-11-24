import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_analysis_controller.dart';

class SurveyAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyAnalysisController>(
      () => SurveyAnalysisController(),
    );
  }
}
