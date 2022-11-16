import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_email_controller.dart';

class PersonalEmailView extends GetView<PersonalEmailController> {
  const PersonalEmailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: BaseData.kBackColor,
      appBar: AppBar(
        title: Text('邮箱'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child:
                Text('确定', style: BaseStyle.topStyle.copyWith(fontSize: 16.sp)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: TextField(
          controller: controller.emailTf,
          autofocus: true,
          // enabled: controller.emailTf.text == '',
          decoration: InputDecoration(hintText: '姓名', border: InputBorder.none),
        ),
      ),
    );
  }
}
