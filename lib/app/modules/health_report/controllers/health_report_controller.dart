import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HealthReportController extends GetxController {
  final address = '江苏省南京市栖霞区'.obs;
  final locationName = ''.obs;
  final longitude = '0'.obs;
  final latitude = '0'.obs;

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
    Result? result = await CityPickers.showCityPicker(context: context);
    address.value = result == null
        ? address.value
        : '${result?.provinceName}${result?.cityName}${result?.areaName}';
    return result;
  }

  void setLocation(String address, String long, String lati) {
    locationName.value = address;
    longitude.value = long;
    latitude.value = lati;
  }
}
