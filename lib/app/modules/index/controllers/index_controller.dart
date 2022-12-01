import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/views/bench_view.dart';
import 'package:wit_niit/app/modules/contacts/views/contacts_view.dart';
import 'package:wit_niit/app/modules/home/views/home_view.dart';
import 'package:wit_niit/app/modules/message/views/message_view.dart';

class IndexController extends GetxController {
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
  final GlobalKey<ScaffoldState> indexScaffoldKey = new GlobalKey<ScaffoldState>();
  open() {
    indexScaffoldKey.currentState?.openDrawer();
  }

  /// 在Widget内存中分配后立即调用，可以用它来初始化initialize一些东西
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage);
    bottomTabs = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          backgroundColor: Colors.orange,
          icon: Icon(
            Icons.message_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.message, size: 25),
          label: '消息'),
      BottomNavigationBarItem(
          backgroundColor: Colors.green,
          icon: Icon(
            Icons.email_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.email, size: 25),
          label: '邮件'),
      BottomNavigationBarItem(
          backgroundColor: Colors.red,
          icon: Icon(
            Icons.navigation_outlined,
            size: 20,
          ),
          activeIcon: Icon(Icons.navigation, size: 25),
          label: '工作台'),
      BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: Icon(
            Icons.person_outline,
            size: 20,
          ),
          activeIcon: Icon(Icons.person, size: 25),
          label: '通讯录'),
    ];

    tabPageBodies = <Widget>[
      MessageView(), // 消息
      HomeView(),
      BenchView(), // 工作台
      ContactsView(), // 通讯录
    ];
  }
}
