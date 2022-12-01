import 'package:city_pickers/city_pickers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../login/model/user_model.dart';

class HealthReportController extends GetxController {
  final address = '江苏省南京市栖霞区'.obs; //常住地址
  final locationName = ''.obs; //定位地址
  final longitude = '0'.obs;
  final latitude = '0'.obs;
  final addressStreet = ''.obs; //常住街道
  final addressStreetTf = ''.obs;
  final isLocation = '正常'.obs; //定位功能是否正常
  final isInSchool = '是'.obs;
  final isInApartment = '否'.obs;
  final isStayHignrisk = '否'.obs;
  final isTransitHignrisk = '否'.obs;
  final isContactHighriskPersonnel = '否'.obs;
  final isGoAbroad = '否'.obs;
  final isContactOverseasPersonnel = '否'.obs;
  final isNormalTemperature = '否'.obs;
  final isSymptom10 = '否'.obs;
  final healthCodeColor = '绿色'.obs;
  final numberOfCohabitants = ''.obs;
  final isQuarantine = '否'.obs;
  final isSave = true.obs;
  final supplementaryNotes = ''.obs;
  final isTest48 = '是'.obs;
  final isAccinated = '是,已完成'.obs;
  final isSuspectedCovid19 = '否'.obs;
  final isAsymptomaticInfection = '否'.obs;
  final isContactSickPeople = '否'.obs;
  final isInformedByTeacher = '是,已联系告知'.obs;
  final isResponsibleForAuthenticity = '是'.obs;
  final isConfirmedCovid19 = '否'.obs;

  final formKey = GlobalKey<FormBuilderState>();
  final formTeacherKey = GlobalKey<FormBuilderState>();

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
      "userId": user?.sno,
      "isHealthy": "0",
      "reportTime": getTime(),
      "position": locationName.value,
      "address": address.value,
      "addressStreet": addressStreetTf.value,
      "isInSchool": isInSchool.value == '是' ? '1' : '0',
      "isInApartment": isInApartment.value == '是' ? '1' : '0',
      "isTransitHignrisk": isTransitHignrisk.value == '是' ? '1' : '0',
      "isStayHignrisk": isStayHignrisk.value == '是' ? '1' : '0',
      "isContactHighriskPersonnel":
          isContactHighriskPersonnel.value == '是' ? '1' : '0',
      "isGoAbroad": isGoAbroad.value == '是' ? '1' : '0',
      "isContactOverseasPersonnel":
          isContactOverseasPersonnel.value == '是' ? '1' : '0',
      "isNormalTemperature": isNormalTemperature.value == '是' ? '1' : '0',
      "isSymptom10": isSymptom10.value == '是' ? '1' : '0',
      "healthCodeColor": healthCodeColor.value == '绿色'
          ? 0
          : healthCodeColor.value == '黄色'
              ? 1
              : 2,
      "numberOfCohabitants": numberOfCohabitants.value == '5人以上'
          ? 6
          : int.parse(numberOfCohabitants.value),
      "isQuarantine": isQuarantine.value == '是' ? '1' : '0',
      "supplementaryNotes": supplementaryNotes.value
    };
    EasyLoading.show(status: '正在提交');
    request.post('/shisheng/health/teacher', data: dataForm).then((data) {
      EasyLoading.dismiss();
      EasyLoading.showToast('提交成功');
      Get.back();
    }).catchError((e) {
      EasyLoading.showError(e);
    });
  }

  void pushStudentContent() {
    var dataForm = {
      "userId": user?.sno,
      "isHealthy": '1',
      "reportTime": getTime(),
      "position": locationName.value,
      "address": address.value,
      "isInSchool": isInSchool.value == '是' ? '1' : '0',
      "isTest48": isTest48.value == '是' ? '1' : '0',
      "isAccinated": isAccinated.value == '是,已完成' ? '1' : '0',
      "isSymptom10": isSymptom10.value == '是' ? '1' : '0',
      "isSuspectedCovid19": isSuspectedCovid19.value == '是' ? '1' : '0',
      "isConfirmedCovid19": isConfirmedCovid19.value == '是' ? '1' : '0',
      "isAsymptomaticInfection":
          isAsymptomaticInfection.value == '是' ? '1' : '0',
      "isQuarantine": isQuarantine.value == '是' ? '1' : '0',
      "isTransitHignrisk": isTransitHignrisk.value == '是' ? '1' : '0',
      "isStayHignrisk": isStayHignrisk.value == '是' ? '1' : '0',
      "isContactHighriskPersonnel":
          isContactHighriskPersonnel.value == '是' ? '1' : '0',
      "isGoAbroad": isGoAbroad.value == '是' ? '1' : '0',
      "isContactOverseasPersonnel":
          isContactOverseasPersonnel.value == '是' ? '1' : '0',
      "isContactSickPeople": isContactSickPeople.value == '是' ? '1' : '0',
      "isInformedByTeacher": isInformedByTeacher.value == '是,已联系告知' ? '1' : '0',
      "isResponsibleForAuthenticity":
          isResponsibleForAuthenticity.value == '是' ? '1' : '0',
      "supplementaryNotes": supplementaryNotes.value,
    };
    EasyLoading.show(status: '正在提交');
    request.post('/shisheng/health', data: dataForm).then((data) {
      EasyLoading.dismiss();
      EasyLoading.showToast('提交成功');
      Get.back();
    }).catchError((e) {
      EasyLoading.showError(e);
    });
  }
}
