import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';

class PersonalAvatarView extends GetView {
  const PersonalAvatarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('头像'),
        centerTitle: true,
        actions: [
          IconButton(
              tooltip: '单击底部出现可供选择的Sheet，进行更多操作',
              onPressed: () {
                Get.bottomSheet(Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () => LogUtil.v('从手机相册选择'),
                          child: Container(
                            child: Text(
                              '从手机相册选择',
                              textAlign: TextAlign.center,
                            ),
                            width: Get.width,
                          )),
                      Divider(
                        color: Colors.grey.shade200,
                        height: 0.h,
                      ),
                      TextButton(
                          onPressed: () => LogUtil.v('保存到手机'),
                          child: Container(
                            child: Text(
                              '保存到手机',
                              textAlign: TextAlign.center,
                            ),
                            width: Get.width,
                          )),
                      Divider(
                        thickness: 10,
                        color: Colors.grey.shade200,
                      ),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: Container(
                            child: Text(
                              '取消',
                              textAlign: TextAlign.center,
                            ),
                            width: Get.width,
                          )),
                    ],
                  ),
                ));
              },
              icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Center(
          child: Container(
        height: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage('${user?.photo}'))),
      )),
    );
  }
}
