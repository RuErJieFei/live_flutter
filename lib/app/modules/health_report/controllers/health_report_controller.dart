import 'package:city_pickers/city_pickers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../login/model/user_model.dart';

class HealthReportController extends GetxController {
  final address = '江苏省南京市栖霞区'.obs; //常住地址
  final locationName = ''.obs; //定位地址
  final longitude = '0'.obs;
  final latitude = '0'.obs;
  final addressStreet = ''.obs; //常住街道
  TextEditingController addressStreetTf = TextEditingController();
  final isLocation = 0.obs; //定位功能是否正常
  final isInSchool = 0.obs;
  final isInApartment = 0.obs;
  final isStayHignrisk = 0.obs;
  final isTransitHignrisk = 0.obs;
  final isContactHighriskPersonnel = 0.obs;
  final isGoAbroad = 0.obs;
  final isContactOverseasPersonnel = 0.obs;
  final isNormalTemperature = 0.obs;
  final isSymptom10 = 0.obs;
  final healthCodeColor = 0.obs;
  final numberOfCohabitants = 0.obs;
  final isQuarantine = 0.obs;
  final isSave = true.obs;

  String getTime() {
    DateTime today = new DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')} ${today.hour.toString().padLeft(2, '0')}:${today.minute.toString().padLeft(2, '0')}:${today.second.toString().padLeft(2, '0')}";
  }

  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  var data = {
    "isHealthy": "1",
    "reportTime": "2022-11-21 15:58:46",
    "position": "定位信息",
    "address": "江苏省-南京市-栖霞区",
    "addressStreet": "仙林街道",
    "isInSchool": "1",
    "isInApartment": "0",
    "isTransitHignrisk": "0",
    "isStayHignrisk": "0",
    "isContactHighriskPersonnel": "0",
    "isGoAbroad": "0",
    "isContactOverseasPersonnel": "0",
    "isNormalTemperature": "1",
    "isSymptom10": "0",
    "healthCodeColor": 0,
    "numberOfCohabitants": 0,
    "isQuarantine": "0",
    "supplementaryNotes": "补充信息"
  };
  @override
  void onInit() {
    // address.value = user?.
  }

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
