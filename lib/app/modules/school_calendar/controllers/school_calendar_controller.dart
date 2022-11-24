
import 'package:get/get.dart';

class SchoolCalendarController extends GetxController {
  //TODO: Implement SchoolCalendarController
  var selectedValue = '2022-2023年第一学期(共21周)'.obs;
  final count = 0.obs;
  var semesterList = [
    "2018-2019年第一学期(共21周)",
    "2018-2019年第二学期(共21周)",
    "2019-2020年第一学期(共21周)",
    "2019-2020年第二学期(共21周)",
    "2020-2021年第一学期(共21周)",
    "2020-2021年第二学期(共21周)",
    "2021-2022年第一学期(共21周)",
    "2021-2022年第二学期(共21周)",
  ].obs;


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

  void increment() => count.value++;
}
