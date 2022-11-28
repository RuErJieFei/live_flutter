import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';

class SurveyWriteController extends GetxController {
  var writeSurveyList = <QueContentList>[].obs;
  @override
  void onInit() {
    writeSurveyList.add(QueContentList(title: '标题x'));
    writeSurveyList.add(QueContentList(title: '标题xx'));
    writeSurveyList.add(QueContentList(title: '标题xxx'));
    // 监听count的值,当它发生改变的时候调用
    ever(writeSurveyList, (callback) => print("ever----${writeSurveyList}"));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
