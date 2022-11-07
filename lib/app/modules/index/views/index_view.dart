import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/index/controllers/index_controller.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
