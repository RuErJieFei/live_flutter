import 'package:get/get.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

class BenchController extends GetxController {
  //TODO: Implement BenchController

  @override
  void onInit() {
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

  final epidemic = [
    BenchItem('智慧入校', 'images/school/school_bg.png', Routes.EnterSchool),
    BenchItem('学生健康上报', 'images/school/school_bg.png', Routes.HEALTH_REPORT),
  ];
  final information = [
    BenchItem('南工资讯', 'images/school/school_bg.png', Routes.CAMPUS_NEWS),
    BenchItem('通知公告', 'images/school/school_bg.png', Routes.NOTICE),
  ];
  final work = [
    BenchItem('网络保障', 'images/school/school_bg.png', Routes.NETWORK),
    BenchItem('学生请销价', 'images/school/school_bg.png', Routes.ASK_LEAVE),
  ];
  final basic = [
    BenchItem('上课直播', 'images/school/school_bg.png', Routes.LIVE_CLASS),
    BenchItem('校园邮箱', 'images/school/school_bg.png', Routes.CAMPUS_MAIL),
  ];
  // 工具箱
  final tools = [
    BenchItem('智慧教室', 'images/school/school_bg.png', Routes.WIT_CLASSROOM),
    BenchItem('微盘', 'images/school/school_bg.png', Routes.MICRO_DISK),
    BenchItem('日程', 'images/school/school_bg.png', Routes.Schedule),
    BenchItem('校历', 'images/school/school_bg.png', Routes.SCHOOL_CALENDAR),
    BenchItem('课程表', 'images/school/school_bg.png', Routes.TIMETABLE),
  ];
}

/// 工作台项目
class BenchItem {
  final String title;
  final String ImgUrl;
  final String route;
  BenchItem(this.title, this.ImgUrl, this.route);
}
