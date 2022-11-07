import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/iconfont.dart';

import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';
import '../controllers/enter_school_index_controller.dart';

class EnterSchoolIndexView extends GetView<EnterSchoolIndexController> {
  const EnterSchoolIndexView({Key? key}) : super(key: key);

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
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.sp,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: SchoolConfig.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '入校申请',
                    style: BaseStyle.topStyle,
                  ),
                  Image.asset('images/school/school_bg.png'),
                ],
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: SchoolConfig.primarySwatchColor.shade200
                              .withOpacity(0.2),
                          border: Border.all(
                              color: SchoolConfig.primaryColor, width: 0.5),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '进行中',
                          style: BaseStyle.schoolSmallStyle,
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        '教职工入校申请',
                        style: BaseStyle.fs16bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    '起止时间：2022-10-09～2022-12-09',
                    style: BaseStyle.graySmallStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.sp,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2022-11-02 星期三',
                        style: BaseStyle.fs16bold,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  RichText(
                    text: TextSpan(text: '', children: [
                      TextSpan(
                        text: '今日',
                        style: BaseStyle.graySmallStyle,
                      ),
                      TextSpan(
                        text: '未申请',
                        style: BaseStyle.schoolSmallStyle,
                      ),
                      TextSpan(
                        text: '，可查看历史记录',
                        style: BaseStyle.graySmallStyle,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              children: <Widget>[
                Icon(IconFont.icon_152),
                Text(
                  '助力疫情防控，静候春暖花开',
                  style: BaseStyle.graySmallStyle,
                ),
              ],
            ),
            SizedBox(
              height: 35.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                rowList(IconFont.icon_wendang, '入校申请', '提前申请入校'),
                rowList(IconFont.icon_wendang1, '历史记录', '查看历史记录'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowList(IconData iconData, String title, String subTitle) {
    return Row(
      children: [
        Icon(
          iconData,
          color: SchoolConfig.primaryColor,
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: BaseStyle.fs14bold,
            ),
            SizedBox(
              height: 5.sp,
            ),
            Text(
              subTitle,
              style: BaseStyle.graySmallStyle,
            ),
          ],
        ),
      ],
    );
  }
}
