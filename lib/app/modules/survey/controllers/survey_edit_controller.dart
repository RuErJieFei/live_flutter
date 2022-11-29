import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/model/personal_gender_model.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';

class SurveyEditController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var data = TemplateModel().obs;
  List tabs = ["编辑", "设置"];
  late TabController tabController;
  // 允许每人提交多份
  var isMultiple = true.obs;
  // 允许填写人修改结果
  var isAllowEdit = true.obs;
  // 匿名填写
  var isNotKnow = false.obs;
  // 提交结果提醒
  var remindList = <PersonalGender>[].obs;
  // 显示的提交结果提醒文字
  var remind = ''.obs;
  // 截止时间
  var endDateTime = DateTime.now().obs;
  // 谁可以填
  var whoCanWrite = [].obs;
  // 谁可以查看收集结果
  var whoCanLookRes = [].obs;

  @override
  void onInit() {
    // 监听count的值,当它发生改变的时候调用
    // ever(data, (callback) => LogUtil.v(data.value.content?.queContentList));
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    remindList.add(
        PersonalGender(genderName: '每次提醒', genderValue: '0', isSelect: true));
    remindList.add(
        PersonalGender(genderName: '每天一次', genderValue: '1', isSelect: false));
    remindList.add(
        PersonalGender(genderName: '永不', genderValue: '2', isSelect: false));
    remind.value = remindList[0].genderName;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
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

  void changeIsMultiple(bool flag) {
    isMultiple.value = flag;
  }

  void changeIsAllowEdit(bool flag) {
    isAllowEdit.value = flag;
  }

  void changeIsNotKnow(bool flag) {
    isNotKnow.value = flag;
  }

  void changeRemindType(PersonalGender personalGender) {
    remindList.forEach((element) {
      if (personalGender.genderValue == element.genderValue) {
        element.isSelect = true;
        remind.value = element.genderName;
      } else {
        element.isSelect = false;
      }
    });
    remindList.refresh();
  }
}
