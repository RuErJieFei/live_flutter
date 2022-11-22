import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_name_controller.dart';

class PersonalNameView extends GetView<PersonalNameController> {
  const PersonalNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: BaseData.kBackColor,
      appBar: AppBar(
        title: Text('姓名'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => controller.changeName(),
            child:
                Text('确定', style: BaseStyle.topStyle.copyWith(fontSize: 16.sp)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: TextField(
          controller: controller.nameTf,
          autofocus: true,
          // enabled: controller.nameTf.text == '',
          decoration: InputDecoration(hintText: '邮箱', border: InputBorder.none),
        ),
      ),
    );
  }
}
