import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wit_niit/app/modules/ask_leave/model/basic_info.dart';
import 'package:wit_niit/main.dart';

import '../model/boolean_object.dart';

class AskLeaveStudentController extends GetxController {
  var basicInfoList = <Widget>[].obs;
  var info = BasicInfo().obs;
  String id = "637c6d880834e0557dd4e5ef";
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cGRhdGVkX2F0IjoiMjAyMi0xMS0yNlQxMjo1Mjo0Ni40MTdaIiwiYWRkcmVzcyI6eyJjb3VudHJ5IjpudWxsLCJwb3N0YWxfY29kZSI6bnVsbCwicmVnaW9uIjpudWxsLCJmb3JtYXR0ZWQiOm51bGx9LCJwaG9uZV9udW1iZXJfdmVyaWZpZWQiOnRydWUsInBob25lX251bWJlciI6IjE3NjA2MTg2MTI0IiwibG9jYWxlIjpudWxsLCJ6b25laW5mbyI6bnVsbCwiYmlydGhkYXRlIjpudWxsLCJnZW5kZXIiOiJNIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJlbWFpbCI6bnVsbCwid2Vic2l0ZSI6bnVsbCwicGljdHVyZSI6Imh0dHBzOi8vZmlsZXMuYXV0aGluZy5jby91c2VyLWNvbnRlbnRzL3Bob3Rvcy80NTI2MWYwYS1hOWVmLTQ3YjAtODRmNy0xZDgyMWU3OTEyYWIuanBlZyIsInByb2ZpbGUiOm51bGwsInByZWZlcnJlZF91c2VybmFtZSI6bnVsbCwibmlja25hbWUiOiLpqaxuYiIsIm1pZGRsZV9uYW1lIjpudWxsLCJmYW1pbHlfbmFtZSI6bnVsbCwiZ2l2ZW5fbmFtZSI6bnVsbCwibmFtZSI6IumprG5iIiwic3ViIjoiNjM3YzZkODgwODM0ZTA1NTdkZDRlNWVmIiwiZXh0ZXJuYWxfaWQiOm51bGwsInVuaW9uaWQiOm51bGwsInVzZXJuYW1lIjoi6amsbmIiLCJkYXRhIjp7InR5cGUiOiJ1c2VyIiwidXNlclBvb2xJZCI6IjYzNjhiMTA2YzU1YzhiMzkzNGE4ZTBmZSIsImFwcElkIjoiNjM2OWZlOGZmY2M3YTZjYzlmMjAyN2FjIiwiaWQiOiI2MzdjNmQ4ODA4MzRlMDU1N2RkNGU1ZWYiLCJ1c2VySWQiOiI2MzdjNmQ4ODA4MzRlMDU1N2RkNGU1ZWYiLCJfaWQiOiI2MzdjNmQ4ODA4MzRlMDU1N2RkNGU1ZWYiLCJwaG9uZSI6IjE3NjA2MTg2MTI0IiwiZW1haWwiOm51bGwsInVzZXJuYW1lIjoi6amsbmIiLCJ1bmlvbmlkIjpudWxsLCJvcGVuaWQiOm51bGwsImNsaWVudElkIjoiNjM2OGIxMDZjNTVjOGIzOTM0YThlMGZlIn0sInVzZXJwb29sX2lkIjoiNjM2OGIxMDZjNTVjOGIzOTM0YThlMGZlIiwiYXVkIjoiNjM2OWZlOGZmY2M3YTZjYzlmMjAyN2FjIiwiZXhwIjoxNjcwNzM3NjM1LCJpYXQiOjE2Njk1MjgwMzUsImlzcyI6Imh0dHBzOi8vc21hcnRzY2hvb2wuYXV0aGluZy5jbi9vaWRjIn0.TZszovSgTo_PsDhSVcXbxx2JTH6ft925n1rLaiFHQSg";
  var infoMap = <String, dynamic>{}.obs;
  var keys = [].obs;
  var values = [].obs;
  var type = "".obs;
  var dateDiffer = 0.obs;
  var phone = "".obs;
  var pageTime = "".obs;

  FormGroup buildForm() => FormGroup(
        {
          'type': FormControl<String>(
              value: this.type.value, validators: [Validators.required]),
          'applicationTime': FormControl<DateTime>(
              value: null, validators: [Validators.required]),
          'deadline': FormControl<DateTime>(
              value: null, validators: [Validators.required]),
          'days':
              FormControl<int>(value: null, validators: [Validators.required]),
          'overnight':
              FormControl<bool>(value: null, validators: [Validators.required]),
          'reason': FormControl<String>(
              value: null, validators: [Validators.required]),
          'number': FormControl<String>(
              value: null, validators: [Validators.required]),
          'occupy':
              FormControl<bool>(value: null, validators: [Validators.required]),
          'out':
              FormControl<bool>(value: null, validators: [Validators.required]),
        },
      );

  // 表单构造器
  // FormGroup buildForm() => FormGroup(
  //
  //     );

  @override
  void onInit() {
    super.onInit();

    // getUserInfo(id, token);
    keys.value = [
      "学号",
      "姓名",
      "性别",
      "电话",
      "学院",
      "班级",
      "现在年级",
      "班主任姓名",
      "班主任电话",
      "住宿地址"
    ];
    values.value = [
      "210501100402",
      "马天浩",
      "男",
      "17606186124",
      "计算机与软件学院",
      "软件2146",
      "2021",
      "葛新艳",
      "",
      "仙林校区筠竹苑1栋316室5号床"
    ];

    this.phone.value = "17606186124";
    this.pageTime.value = DateUtil.getNowDateStr();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///  Authing 获取当前登录用户信息
  void getUserInfo(id, token) async {
    // AuthResult result = await AuthClient.getCurrentUser();
    // User? user = result.user; // user info

    var data = await request.get(
      "/users/getUser/$id",
      headers: {"token": token},
    );
    info.value = BasicInfo.fromJson(data);
    infoMap.value = info.value.toCusJson();
    if (infoMap.isNotEmpty) {
      infoMap
          .forEach((key, value) => _genLists(key.toString(), value.toString()));
      LogUtil.v(keys.toList());
      LogUtil.v(values.toList());
      LogUtil.v(SpUtil.getDynamic("user"));
    }
  }

  void _genLists(key, value) {
    keys.add(key);
    values.add(value);
  }

  void onSubmit(form) {
    LogUtil.v(JsonUtil.encodeObj(form));
  }

  String calculateDiffer(FormGroup form) {
    this.dateDiffer.value = form.control("days").value =
        (DateUtil.getDateTime(form.control("deadline").value.toString())!
                .difference(DateUtil.getDateTime(
                    form.control("applicationTime").value.toString())!)
                .inDays +
            1);
    return this.dateDiffer.value.toString();
  }
}
