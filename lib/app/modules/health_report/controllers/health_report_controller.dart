import 'package:city_pickers/city_pickers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
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
  TextEditingController supplementaryNotes = TextEditingController();
  final isTest48 = 0.obs;
  final isAccinated = 0.obs;
  final isSuspectedCovid19 = 0.obs;
  final isAsymptomaticInfection = 0.obs;
  final isContactSickPeople = 0.obs;
  final isInformedByTeacher = 0.obs;
  final isResponsibleForAuthenticity = 0.obs;

  String getTime() {
    DateTime today = new DateTime.now();
    return "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')} ${today.hour.toString().padLeft(2, '0')}:${today.minute.toString().padLeft(2, '0')}:${today.second.toString().padLeft(2, '0')}";
  }

  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

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

  void pushContent() {
    var dataForm = {
      "userId": user?.id,
      "isHealthy": "0",
      "reportTime": getTime(),
      "position": 'locationName.value',
      // "position": locationName.value,
      "address": address.value,
      "addressStreet": addressStreetTf.text,
      "isInSchool": isInSchool.value.toString(),
      "isInApartment": isInApartment.value.toString(),
      "isTransitHignrisk": isTransitHignrisk.value.toString(),
      "isStayHignrisk": isStayHignrisk.value.toString(),
      "isContactHighriskPersonnel": isContactHighriskPersonnel.value.toString(),
      "isGoAbroad": isGoAbroad.value.toString(),
      "isContactOverseasPersonnel": isContactOverseasPersonnel.value.toString(),
      "isNormalTemperature": isNormalTemperature.value.toString(),
      "isSymptom10": isSymptom10.value.toString(),
      "healthCodeColor": healthCodeColor.value,
      "numberOfCohabitants": numberOfCohabitants.value,
      "isQuarantine": isQuarantine.value.toString(),
      // "supplementaryNotes": supplementaryNotes.text
      "supplementaryNotes": 'supplementaryNotes.text'
    };
    EasyLoading.show(status: '正在提交');
    print(dataForm);
    request.post('/shisheng/health/teacher', data: dataForm).then((data) {
      EasyLoading.dismiss();
      EasyLoading.showToast('提交成功');
      Get.back();
    }).catchError((e) {
      EasyLoading.showError(e);
    });
  }
}
