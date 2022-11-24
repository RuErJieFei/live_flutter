import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/survey_controller.dart';

class SurveyView extends GetView<SurveyController> {
  const SurveyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.indexScaffoldKey,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildPageView(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.currentPage,
          type: BottomNavigationBarType.fixed, // fixed 默认白色，shifting 切换背景色
          // fixedColor: Colors.red,
          selectedFontSize: 16,
          unselectedFontSize: 13,
          onTap: (int index) => controller.switchBottomTabBar(index),
        ));
  }

  /// 内容页
  Widget _buildPageView() {
    return PageView(
      //禁止滑动
      //physics: const NeverScrollableScrollPhysics(),
      children: controller.tabPageBodies,
      controller: controller.pageController,
      onPageChanged: (index) => controller.onPageChanged(index),
    );
  }
}
