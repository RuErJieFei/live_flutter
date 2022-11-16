import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterSchoolHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final tabs = ['待处理', '已批准', '已驳回', '已失效'];

  // 选择
  final authorities = [' 全部 ', '无风险', '有风险', '信息不符'];
  final selected = 0.obs;

  // 迭代器生成list
  // Iterable<Widget> get inputSelects sync* {
  //   for (int i = 0; i < _authorities.length; i++) {
  //     yield ChoiceChipSelect(
  //       index: i,
  //       choice: _authorities[i],
  //       parent: this,
  //     );
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
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
