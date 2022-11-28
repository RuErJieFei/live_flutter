import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';

class SurveyEditController extends GetxController {
  var data = TemplateModel().obs;
  @override
  void onInit() {
    // 监听count的值,当它发生改变的时候调用
    // ever(data, (callback) => LogUtil.v(data.value.content?.queContentList));
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

  void setTemplate(TemplateModel model) {
    data.value = model;
  }

  void renderOptionList(int index, int oldIndex, int newIndex) {
    data.update((val) {
      QueOptions? item =
          val?.content?.queContentList?[index].queOptions?.removeAt(oldIndex);

      val?.content?.queContentList?[index].queOptions?.insert(newIndex, item!);
    });
  }

  void renderList(int oldIndex, int newIndex) {
    LogUtil.v('${oldIndex}, ${newIndex}');
    QueContentList? item =
        data.value.content?.queContentList?.removeAt(oldIndex);
    data.value.content?.queContentList?.insert(newIndex, item!);
    update();
  }
}
