import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_gender_controller.dart';

class PersonalGenderView extends GetView<PersonalGenderController> {
  const PersonalGenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('性别'),
        centerTitle: true,
      ),
      body: Container(
          // child: Column(
          //   children: <Widget>[
          //     Obx(() {
          //       return ListTile(
          //         leading: Text('男'),
          //         trailing: controller.gender == true
          //             ? Icon(Icons.check)
          //             : Container(
          //                 width: 1.w,
          //               ),
          //         onTap: () => controller.changeGender(),
          //       );
          //     }),
          //     ListTile(
          //       leading: Text('女'),
          //       trailing: Icon(Icons.check),
          //       onTap: () {},
          //     ),
          //     ListTile(
          //       leading: Text('未知'),
          //       trailing: Icon(Icons.check),
          //       onTap: () {},
          //     ),
          //   ],
          // ),
          child: Obx(() {
        return ListView.builder(
            itemCount: controller.genderList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(controller.genderList[index].genderName),
                trailing: controller.genderList[index].isSelect == true
                    ? Icon(Icons.check)
                    : Container(
                        width: 1.w,
                      ),
                onTap: () =>
                    controller.changeGender(controller.genderList[index]),
              );
            });
      })),
    );
  }
}
