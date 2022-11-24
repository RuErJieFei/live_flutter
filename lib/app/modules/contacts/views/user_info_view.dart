import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/contacts/controllers/user_info_controller.dart';

class UserInfoView extends GetView<UserInfoController> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            children: [
              Container(
                height: 100.h,
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${controller.user.value.photo}',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text(
                      '${controller.user.value.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.person,
                      color: controller.user.value.gender == "U"
                          ? Colors.pink.shade300
                          : Colors.blue.shade300,
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.mark_email_read,
                    color: Colors.grey,
                  ),
                  title: Transform(
                    transform: Matrix4.translationValues(-22, 0.0, 0.0),
                    child: Text(
                      "开到荼蘼",
                    ),
                  ),
                  trailing: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  ),
                  title: Transform(
                    transform: Matrix4.translationValues(-22, 0.0, 0.0),
                    child: Text(
                      "查看日程",
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    "手机",
                    style: BaseStyle.messageMiddleStyle,
                  ),
                  title: Text(
                    '${controller.user.value.phone}',
                    style: BaseStyle.messageBlueStyle,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    "邮箱",
                    style: BaseStyle.messageMiddleStyle,
                  ),
                  title: Text(
                    '${controller.user.value.email}',
                    style: BaseStyle.messageBlueStyle,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text("部门",style: BaseStyle.messageMiddleStyle),
                  title: Text(
                    '计算机与软件学院',
                    style: BaseStyle.messageMiddleStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "发消息",
                  style: TextStyle(fontSize: 20.sp),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
