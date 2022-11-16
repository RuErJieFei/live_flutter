import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HealthReportController extends GetxController {
  @override
  void onInit() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // 通过钩子事件, 主动唤起浮层.
  Future<Result?> getResult(BuildContext context) async {
    Result? result = await CityPickers.showFullPageCityPicker(context: context);

    return result;
  }
}
