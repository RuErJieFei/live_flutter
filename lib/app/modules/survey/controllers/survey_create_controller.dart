import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_edit_controller.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';
import 'package:wit_niit/main.dart';

class SurveyCreateController extends GetxController {
  var templateList = <TemplateModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadData() async {
    Map<String, dynamic> params = {"page": 1, "limit": 50};
    var res = await request.post('/survey/template/list', params: params);
    var data = res["content"];
    data.forEach((e) {
      TemplateModel contact = TemplateModel.fromJson(e);
      templateList.add(contact);
    });
  }

  /// 传id给下一个页面
  setTemplate(TemplateModel model) {
    var personal = Get.find<SurveyEditController>();
    personal.setTemplate(model);
  }
}
