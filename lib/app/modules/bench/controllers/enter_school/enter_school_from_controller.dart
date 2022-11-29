import 'package:dio/dio.dart' as dio;
import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';

import '../../../../../main.dart';
import '../../../login/model/user_model.dart';

class EnterSchoolFromController extends GetxController {
  // static EnterSchoolFromController get to => Get.find(); // 添加这一行
  final today = true.obs;
  final peerHealthy = 0.obs;
  final riskRegion = 0.obs;
  final sicken = 0.obs;
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
  var healthyImageUrl =
      'https://tva1.sinaimg.cn/large/008vxvgGgy1h85sfues11j30u00tdjtp.jpg'.obs;
  var tripImageUrl =
      'https://tva1.sinaimg.cn/large/008vxvgGgy1h85sfues11j30u00tdjtp.jpg'.obs;

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

  void selectedDate(selected) {
    today.value = selected;
  }

  /// 相册选择
  Future getImage(int type) async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
    );
    upload(res, type);
  }

  /// 打开相机拍摄
  Future getPhoto(int type) async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.video,
      cropOpt: CropOption(),
    );
    upload(res, type);
  }

  /// 上传头像、修改用户头像
  void upload(List<Media>? res, int type) async {
    if (res != null) {
      String? path = res[0].path; // 本地图片地址

      Get.back();

      // 给dio取别名
      // 因为 FormData 和 MultipartFile 在 get 中也有
      // 两个之间冲突了
      // 图片上传 formdata
      var formData = dio.FormData.fromMap(
          {'image': await dio.MultipartFile.fromFile(path)});
      var uploadAvatar = await request.post('/file/upload', data: formData);

      if (uploadAvatar != '') {
        LogUtil.v(uploadAvatar);
        if (type == 0) {
          healthyImageUrl.value = uploadAvatar;
          healthyImageUrl.refresh();
        } else {
          tripImageUrl.value = uploadAvatar;
          tripImageUrl.refresh();
        }
      } else {
        EasyLoading.showError(type == 0 ? '上传苏康码错误' : '上传行程码错误');
      }
    }
  }

  void pushSchool() {
    DateTime dateTime = DateTime.now();
    var param = {
      "peerHealthy": peerHealthy.value == 0 ? true : false,
      "tripImageUrl": tripImageUrl.value,
      "admissionTime": today.value == true
          ? "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}"
          : "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${(dateTime.day + 1).toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}",
      "sicken": sicken.value == 0 ? true : false,
      "userId": user?.id,
      "healthyImageUrl": healthyImageUrl.value,
      "riskRegion": riskRegion.value == 0 ? true : false,
    };
    EasyLoading.show(status: '正在提交');
    request.post('/entrance/add', data: param).then((data) {
      EasyLoading.dismiss();
      EasyLoading.showToast('提交成功');
      Get.back();
    }).catchError((e) {
      EasyLoading.showError(e);
    });
  }
}
