import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_status_controller.dart';
import 'package:wit_niit/app/modules/personal/model/personal_status_model.dart';

class PersonalStatusView extends GetView<PersonalStatusController> {
  const PersonalStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Scaffold(
      // 背景色
      backgroundColor: Config.mainColor.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: '返回上一页',
          icon: Icon(
            Icons.close,
            color: Colors.black87,
            size: 32,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            tooltip: '保存当前状态结果',
            icon: Icon(
              Icons.check,
              color: Colors.black87,
              size: 32,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: Obx(() {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.personalStatusList.length,
                          physics: new NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              itemBuild(context, index),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10.h);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuild(BuildContext context, int index) {
    return StatusItem(
      index: index,
      personalStatus: controller.personalStatusList[index],
    );
  }
}

class StatusItem extends GetView<PersonalStatusController> {
  const StatusItem(
      {Key? key, required this.index, required this.personalStatus})
      : super(key: key);

  final int index;
  final PersonalStatus personalStatus;

  @override
  Widget build(BuildContext context) {
    VoidCallback method;
    if (index == 0) {
      method = () => LogUtil.v('新增状态');
    } else {
      method = () => controller.changeSelected(personalStatus);
    }
    return TextButton(
      onPressed: method,
      child: Container(
        width: 170.w,
        height: 150.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${personalStatus.statusIcon}',
              style: BaseStyle.fs26.copyWith(fontSize: 36.sp),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${personalStatus.statusLabel}',
              style: BaseStyle.fs18,
            ),
          ],
        ),
      ),
      style: TextButton.styleFrom(
          foregroundColor:
              personalStatus.isSelect == true ? Colors.white : Colors.black87,
          backgroundColor:
              personalStatus.isSelect == true ? Config.mainColor : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
