import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/health_report/views/location_view.dart';

import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';
import '../controllers/health_report_controller.dart';

TextStyle textStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontSize: 14.sp,
);

TextStyle textBoldStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

class HealthReportView extends GetView<HealthReportController> {
  const HealthReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '【健康上报】教职员工',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primarySwatchColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: SchoolConfig.primarySwatchColor.shade50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 15.h,
                      color: SchoolConfig.primarySwatchColor.shade400,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 15.h,
                      color: SchoolConfig.primarySwatchColor.shade600,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 15.h,
                      color: SchoolConfig.primarySwatchColor.shade500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '每天12:00前填报个人健康情况',
                      style: TextStyle(
                        color: SchoolConfig.primarySwatchColor.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(),
                    title('姓名'),
                    SizedBox(
                      height: 10.0,
                    ),
                    tagCircle(
                        'https://avatars.githubusercontent.com/u/59445871?v=4',
                        '陈蓉琪'),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('部门（单位）'),
                    SizedBox(
                      height: 10.0,
                    ),
                    tagCircle(
                        'https://avatars.githubusercontent.com/u/59445871?v=4',
                        '29.0计算机与软件学院'),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('10位工号'),
                    SizedBox(
                      height: 10.0,
                    ),
                    formBorder('21501100117', true),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('手机长号'),
                    SizedBox(
                      height: 10.0,
                    ),
                    formBorder('21501100117', true),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('常住地址'),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      child: Obx(
                        () => formBorder(controller.address.value, false,
                            showSelect: true),
                      ),
                      onTap: () {
                        controller.getResult(context);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('手机定位功能是否正常'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        radioTag('green', '正常'),
                        SizedBox(
                          width: 20.w,
                        ),
                        radioTag('red', '不正常'),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    title('当前定位'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '务必', style: BaseStyle.graySmallStyle),
                            TextSpan(text: '赋予'),
                            TextSpan(
                                text: '当前软件', style: BaseStyle.graySmallStyle),
                            TextSpan(text: '定位权限'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '一次定位不成功，',
                                style: BaseStyle.graySmallStyle),
                            TextSpan(text: '清空地址'),
                            TextSpan(
                                text: '后，可以', style: BaseStyle.graySmallStyle),
                            TextSpan(text: '再次尝试'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: '或者打开，', style: BaseStyle.graySmallStyle),
                            TextSpan(text: 'GPS'),
                            TextSpan(
                                text: '，到', style: BaseStyle.graySmallStyle),
                            TextSpan(text: '室外'),
                            TextSpan(
                                text: '进行', style: BaseStyle.graySmallStyle),
                            TextSpan(text: '定位'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () => controller.locationName.value == ''
                          ? Container()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: SchoolConfig.primarySwatchColor.shade50,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: SchoolConfig
                                        .primarySwatchColor.shade400
                                        .withOpacity(0.3),
                                    width: 0.6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.locationName.value,
                                    style: textBoldStyle,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Divider(),
                                  Text(
                                    '纬度：${controller.longitude.value}，经度：${controller.latitude.value}',
                                    style: BaseStyle.graySmallStyle,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.setLocation(
                                        '',
                                        '',
                                        '',
                                      );
                                    },
                                    child: Text(
                                      '清空',
                                      style: BaseStyle.schoolContentStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var res = await Get.to(() => LocationView());
                        controller.setLocation(
                          res['list']['addr'].toString(),
                          res['longitude'].toString(),
                          res['latitude'].toString(),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: SchoolConfig.primarySwatchColor.shade50,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: SchoolConfig.primarySwatchColor.shade400
                                  .withOpacity(0.3),
                              width: 0.6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: SchoolConfig.primarySwatchColor.shade400
                                  .withOpacity(0.5),
                            ),
                            Text(
                              '选择定位',
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    title('今天是否到校'),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        radioTag('normal', '是'),
                        SizedBox(
                          width: 20.w,
                        ),
                        radioTag('normal', '否'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
                color: SchoolConfig.primarySwatchColor.shade500,
                fontSize: 16.sp),
          ),
          TextSpan(text: title, style: textBoldStyle),
        ],
      ),
    );
  }

  Widget tagCircle(String avatar, String name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
      decoration: BoxDecoration(
        color: SchoolConfig.primarySwatchColor.shade100,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: SchoolConfig.primarySwatchColor.shade400.withOpacity(0.3),
            width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundImage: NetworkImage(avatar),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            name,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget formBorder(String title, bool disable, {bool showSelect = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: disable
            ? SchoolConfig.primarySwatchColor.shade100
            : SchoolConfig.primarySwatchColor.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color: SchoolConfig.primarySwatchColor.shade400.withOpacity(0.3),
            width: 0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle,
          ),
          showSelect
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                )
              : Container()
        ],
      ),
    );
  }

  Widget radioTag(String color, String content) {
    return Row(
      children: [
        Radio(
          value: 0,
          groupValue: 0,
          onChanged: (e) {},
          activeColor: SchoolConfig.primarySwatchColor.shade400,
        ),
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 3.0, horizontal: color == 'normal' ? 1.0 : 10.0),
          decoration: color == 'normal'
              ? BoxDecoration()
              : BoxDecoration(
                  color: color == 'green' ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(15.0),
                ),
          child: Text(
            content,
            style: TextStyle(
                color: color == 'normal'
                    ? SchoolConfig.primarySwatchColor.shade400
                    : Colors.white,
                fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
