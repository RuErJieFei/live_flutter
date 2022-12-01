import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/health_report/model/health_model.dart';

import '../../../../main.dart';
import '../../login/model/user_model.dart';

class HealthTableController extends GetxController {
  final healthList = [].obs;
  final totalNum = 1.obs;
  final pageNum = 1.obs;
  final pageSize = 500.obs;
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  @override
  void onInit() async {
    super.onInit();
    if (user?.roleList![0] == 'student') {
      healthList.value = await getSchoolByDate();
      healthList.value = healthList.map((element) {
        return HealthModel.fromJson(element);
      }).toList();
      update();
    }
  }

  Future<List> getSchoolByDate() async {
    var param = {
      "pageNum": pageNum.value,
      "pageSize": pageSize.value,
      "studentId": user?.sno
    };
    var res = await request.get("/shisheng/health/student", params: param);
    totalNum.value = res['total'];
    return res['list'];
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
