import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_gradinent.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_email_bind_binding.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_email_controller.dart';
import 'package:wit_niit/app/modules/personal/views/personal_email_bind_view.dart';

class PersonalEmailView extends GetView<PersonalEmailController> {
  const PersonalEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Scaffold(
      appBar: AppBar(
        title: const Text('邮箱'),
        centerTitle: true,
      ),
      //通过ConstrainedBox来确保Stack占满屏幕
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_rounded,
                    size: 150,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h), child: Text('当前邮箱')),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text(
                      '${user?.email}',
                      style: BaseStyle.contentStyle.copyWith(fontSize: 32.sp),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 166.h,
                child: InkWell(
                    onTap: () => Get.to(() => PersonalEmailBindView(),
                        binding: PersonalEmailBindBinding()),
                    child: BGGradient(
                      alignment: Alignment.center,
                      width: Get.width * 0.8,
                      height: Get.width / 8,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Text(
                        '更换邮箱',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
