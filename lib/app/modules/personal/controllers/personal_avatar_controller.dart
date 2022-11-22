import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flustars/flustars.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_controller.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_info_controller.dart';
import 'package:wit_niit/main.dart';

class PersonalAvatarController extends GetxController {
  var avatar = ''.obs;
  UserModel? user = SpUtil.getObj(
      "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

  @override
  void onInit() {
    super.onInit();
    avatar.value = (user?.photo)!;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 打开相册选择
  void openImageList() async {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      // 图像裁剪
      cropOpt: CropOption(
          // aspectRatio: CropAspectRatio.wh16x9,
          // cropType: CropType.circle,
          ),
    );
    // 调用修改头像的方法
    changeAvatar(res);
  }

  /// 打开相机拍摄
  void openCamera() async {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      cropOpt: CropOption(),
    );
    // 调用修改头像的方法
    changeAvatar(res);
  }

  /// 上传头像、修改用户头像
  void changeAvatar(List<Media>? res) async {
    if (res != null) {
      String? path = res[0].path; // 本地图片地址
      LogUtil.v(path);

      Get.back();

      // 给dio取别名
      // 因为 FormData 和 MultipartFile 在 get 中也有
      // 两个之间冲突了
      // 图片上传 formdata
      var formData = dio.FormData.fromMap(
          {'photo': await dio.MultipartFile.fromFile(path)});
      var uploadAvatar = await request.post('/users/upload', data: formData);

      if (uploadAvatar != '') {
        avatar.value = uploadAvatar;
        avatar.refresh();
      } else {
        EasyLoading.showError('上传头像错误');
      }

      // 修改个人信息
      var dataForm = {
        "photo": "${avatar.value}",
        "gender": "${user?.gender}",
        "name": "${user?.name}",
        "id": "${user?.id}"
      };
      var modifyData = await request.post('/users/edit', data: dataForm);
      if (modifyData["name"] != '') {
        /// 获取用户信息
        getUserInfo(modifyData["id"]);

        // 同步修改跳转过来的页面上的头像的值
        var personalInfo = Get.find<PersonalInfoController>();
        personalInfo.changeAvatar(avatar.value);

        var personal = Get.find<PersonalController>();
        personal.changeAvatar(avatar.value);
        EasyLoading.showToast('修改成功');
        Get.back();
      } else {
        EasyLoading.showError('修改个人资料错误');
      }
    }
  }

  /// 保存头像在本地相册
  void saveAvatarLocal(String? url) async {
    File file = await downloadFile(url);
    bool res = await ImagesPicker.saveImageToAlbum(file, albumName: "智慧南工");
    LogUtil.v(res);
  }

  /// 下载头像
  Future<File> downloadFile(String? url) async {
    dio.Dio simple = dio.Dio();
    String savePath = Directory.systemTemp.path + '/' + url!.split('/').last;
    await simple.download(url, savePath,
        options: dio.Options(responseType: dio.ResponseType.bytes));
    if (savePath != '') {
      EasyLoading.showToast('保存成功');
    }
    print(savePath);
    File file = new File(savePath);
    Get.back();
    return file;
  }

  /// 获取当前登录用户信息
  void getUserInfo(id) async {
    var data = await request.get("/users/getUser/$id");
    UserModel user = UserModel.fromJson(data);
    SpUtil.putObject("user", user);
  }
}
