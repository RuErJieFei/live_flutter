import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/enter_school_from_controller.dart';

import '../../../component/school_push_buttton.dart';
import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';

class EnterSchoolFromView extends GetView<EnterSchoolFromController> {
  // const EnterSchoolFromView({Key? key}) : super(key: key);
  GlobalKey anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '入校申请',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              schoolTitle('入校日期'),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  schoolDate(context, true),
                  SizedBox(
                    width: 10.w,
                  ),
                  schoolDate(context, false),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [schoolTitle('入校日期'), addPhoto()],
              ),
              SizedBox(
                height: 10.h,
              ),
              RichText(
                text: TextSpan(
                  text: '',
                  children: [
                    TextSpan(
                      text: '* 请上传本人含核酸时间的【苏康码】，入校时核酸检测时效性需符合48小时内要求',
                      style: TextStyle(
                        color: Colors.red.shade600,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '查看示例',
                      style: TextStyle(
                        color: SchoolConfig.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return dialog(context);
                            },
                            transitionBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return ScaleTransition(
                                alignment: Alignment.center,
                                scale: animation,
                                child: child,
                              );
                            },
                          );
                        },
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [schoolTitle('行程码'), addPhoto()],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '其他问题',
                style: BaseStyle.smallStyle,
              ),
              SizedBox(
                height: 10.h,
              ),
              cardBox('同住人双码是否全绿', 1, 0),
              SizedBox(
                height: 10.h,
              ),
              cardBox('同住人有无中高风险地区行程史', 2, 1),
              SizedBox(
                height: 10.h,
              ),
              cardBox('本人是否有发热、干咳、乏力、鼻塞流涕、咽痛、嗅觉/味觉减退、结膜炎、肌痛、腹泻等症状', 3, 1),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    activeColor: SchoolConfig.primaryColor, //选中时的颜色
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '本人承诺以上信息真实有效，如有虚假本人承担一切责任',
                          style: BaseStyle.smallStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              SchoolPushButton(
                title: '提交',
                onTap: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget schoolTitle(String title) {
    return RichText(
      text: TextSpan(
        text: '',
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red.shade800,
              fontSize: 14.sp,
            ),
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: title,
            style: BaseStyle.smallStyle,
          ),
        ],
      ),
    );
  }

  Widget schoolQuestionTitle(String title, int index) {
    return RichText(
      text: TextSpan(
        text: '',
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
              color: Colors.red.shade800,
              fontSize: 14.sp,
            ),
          ),
          TextSpan(text: ' '),
          TextSpan(
            text: 'Q$index: ',
            style: BaseStyle.schoolBoldSmallStyle,
          ),
          TextSpan(
            text: title,
            style: BaseStyle.smallBBoldStyle,
          ),
        ],
      ),
    );
  }

  Widget schoolDate(BuildContext context, bool selected) {
    DateTime dateTime = DateTime.now();

    return InkWell(onTap: () {
      controller.selectedDate(selected);
    }, child: Obx(() {
      return Container(
        padding: EdgeInsets.all(10.0),
        width: 66.w,
        decoration: BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade200.withOpacity(0.2),
          border: selected == controller.today.value
              ? Border.all(color: SchoolConfig.primaryColor, width: 2)
              : Border.all(
                  color:
                      SchoolConfig.primarySwatchColor.shade200.withOpacity(0.2),
                  width: 0,
                ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Text(
              selected ? '今日' : '明日',
              style: BaseStyle.schoolSmallStyle,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              '${dateTime.month}-${selected ? dateTime.day : dateTime.day + 1}',
              style: BaseStyle.smallStyle,
            ),
          ],
        ),
      );
    }));
  }

  Widget addPhoto() {
    return PopupMenuButton(
      offset: Offset(0, 60.h),
      itemBuilder: (context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            height: 25.h,
            value: '照片图库',
            child: Container(
              padding: EdgeInsets.all(3.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('照片图库'),
                  SizedBox(
                    width: 35.w,
                  ),
                  Icon(
                    Icons.photo_outlined,
                    color: SchoolConfig.primaryColor,
                  )
                ],
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            height: 25.h,
            value: '拍照',
            child: Container(
              padding: EdgeInsets.all(3.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('拍照'),
                  SizedBox(
                    width: 35.w,
                  ),
                  Icon(
                    Icons.camera_outlined,
                    color: SchoolConfig.primaryColor,
                  )
                ],
              ),
            ),
          ),
          PopupMenuDivider(),
          PopupMenuItem<String>(
            height: 25.h,
            value: '选取文件',
            child: Container(
              padding: EdgeInsets.all(3.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('选取文件'),
                  SizedBox(
                    width: 35.w,
                  ),
                  Icon(
                    Icons.file_copy_outlined,
                    color: SchoolConfig.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ];
      },
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        child: Icon(
          Icons.add,
          color: SchoolConfig.primaryColor,
          size: 30.r,
        ),
      ),
    );
  }

  Widget dialog(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Dialog(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '苏康码示例',
                    style: BaseStyle.schoolBoldContentStyle,
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 300.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '一、截图需含本人',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '【姓名】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                    TextSpan(
                                      text: '和',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '【证件号码】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '二、截图日期为',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '【今天】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '三、截图内含',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '【核酸检测时间】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '四、截图前建议',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '使用手机系统【默认字体】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '五、截图需保持图片',
                                      style: BaseStyle.graySmallStyle,
                                    ),
                                    TextSpan(
                                      text: '【完整清晰】',
                                      style: BaseStyle.smallBoldStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Image.network(
                            'https://tva1.sinaimg.cn/large/008vxvgGgy1h7xs4lqvuvj30k614swk5.jpg',
                            width: 150.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '已知晓',
                      style: BaseStyle.contentStyle,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget cardBox(String title, int index, int type) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            schoolQuestionTitle(title, index),
            SizedBox(
              height: 5.h,
            ),
            Divider(),
            Row(
              children: [
                Obx(() {
                  return Radio(
                    value: 0,
                    activeColor: SchoolConfig.primaryColor,
                    groupValue: controller.isGreen.value,
                    onChanged: (value) {
                      controller.setGreen(value);
                    },
                  );
                }),
                Text(type == 0 ? "全绿码" : "无"),
              ],
            ),
            Row(
              children: [
                Obx(() {
                  return Radio(
                    value: 1,
                    activeColor: SchoolConfig.primaryColor,
                    groupValue: controller.isGreen.value,
                    onChanged: (value) {
                      controller.setGreen(value);
                    },
                  );
                }),
                Text(type == 0 ? "非全绿码" : "有")
              ],
            )
          ],
        ),
      ),
    );
  }
}
