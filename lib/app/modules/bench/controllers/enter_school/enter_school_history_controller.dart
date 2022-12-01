import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../main.dart';
import '../../../login/model/user_model.dart';
import '../../model/school_model.dart';

class EnterSchoolHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  final tabs = ['待处理', '已批准', '已驳回', '已失效'];

  // 选择
  final authorities = [
    {'name': ' 全部 ', 'value': 0},
    {'name': ' 无风险 ', 'value': 1},
    {'name': ' 有风险 ', 'value': 2},
    {'name': '信息不符 ', 'value': 3}
  ];
  final selected = 0.obs;
  var schoolList = [].obs;
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
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
  void onInit() async {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    schoolList.value = await getSchoolByDate();
    schoolList.value =
        schoolList.map((element) => SchoolData.fromJson(element)).toList();
    update();
  }

  Future<List> getSchoolByDate() async {
    String? userId = user?.id;
    var res = await request.get("/entrance/select?userId=$userId");
    return res;
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
