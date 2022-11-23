import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/views/survey_analysis_view.dart';
import 'package:wit_niit/app/modules/survey/views/survey_create_view.dart';
import 'package:wit_niit/app/modules/survey/views/survey_write_view.dart';

class SurveyController extends GetxController {
  /// 响应式成员变量，默认位置指引0
  final _currentPage = 0.obs;
  set currentPage(index) => _currentPage.value = index;
  get currentPage => _currentPage.value;

  /// PageView页面控制器
  late PageController pageController;
  //Page页面集合
  late List<Widget> tabPageBodies;

  /// 底部BottomNavigationBarItem
  late List<BottomNavigationBarItem> bottomTabs;

  switchBottomTabBar(int index) {
    //点击底部BottomNavigationBarItem切换PageView页面
    //pageController.animateToPage(index,duration: Duration(seconds: 1),curve: Curves.fastLinearToSlowEaseIn);
    pageController.jumpToPage(index);
  }

  onPageChanged(int index) {
    currentPage = index;
  }

  /// 打开抽屉
  final GlobalKey<ScaffoldState> indexScaffoldKey =
      new GlobalKey<ScaffoldState>();

  /// 在Widget内存中分配后立即调用，可以用它来初始化initialize一些东西
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage);
    bottomTabs = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(
            Icons.edit_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.edit, size: 25),
          label: '填写'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.leaderboard_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.leaderboard, size: 25),
          label: '统计'),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.library_add_check_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.library_add_check, size: 25),
          label: '新建'),
    ];

    tabPageBodies = <Widget>[
      SurveyWriteView(), // 消息
      SurveyAnalysisView(),
      SurveyCreateView(), // 工作台
    ];
  }
}
