import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/contacts/model/dept_data.dart';
import 'package:wit_niit/app/modules/contacts/model/dept_model.dart';
import 'package:wit_niit/main.dart';

class DeptController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    deptData = Get.arguments;
    getDeptList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  late DeptData deptData;
  final _page = 0.obs;
  final _size = 99.obs;
  List<DeptModel> list = <DeptModel>[].obs;

  ///部门列表
  void getDeptList() async {
    Map<String, int> params = {
      "page": _page.value,
      "size": _size.value,
      "typeId": deptData.typeId,
      "deptId": deptData.deptId
    };
    await request.post("${NetUrl.message_HostName}/community/dept/list", params: params).then((data) {
      List result = data['data'];
      list.clear();
      if (deptData.typeId == 2 && deptData.deptId == 0) {
        List<DeptModel> deptList = <DeptModel>[].obs;
        deptList.addAll(result.map((e) => DeptModel.fromJson(e)).toList());
        deptList.forEach((element) {
          if (element.parentId.length == 1) {
            list.add(element);
          }
        });
      } else {
        list.addAll(result.map((e) => DeptModel.fromJson(e)).toList());
      }
    });
  }
}
