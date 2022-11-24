import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
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
    var res = await request
        .post('${NetUrl.survey_HostName}/survey/template/list', params: params);
    var data = res["content"];
    data.forEach((e) {
      TemplateModel contact = TemplateModel.fromJson(e);
      templateList.add(contact);
    });
  }
}
