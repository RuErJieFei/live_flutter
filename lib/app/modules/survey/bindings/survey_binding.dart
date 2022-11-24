import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_analysis_controller.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_create_controller.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_edit_controller.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_write_controller.dart';

import '../controllers/survey_controller.dart';

class SurveyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyEditController>(
      () => SurveyEditController(),
    );
    Get.lazyPut<SurveyCreateController>(
      () => SurveyCreateController(),
    );
    Get.lazyPut<SurveyAnalysisController>(
      () => SurveyAnalysisController(),
    );
    Get.lazyPut<SurveyWriteController>(
      () => SurveyWriteController(),
    );
    Get.lazyPut<SurveyController>(
      () => SurveyController(),
    );
  }
}
