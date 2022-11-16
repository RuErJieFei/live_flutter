import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/base_style.dart';
import '../../../../data/iconfont.dart';
import '../../../../data/school_theme_data.dart';
import '../../bindings/enter_school/enter_school_index_binding.dart';
import '../../controllers/enter_school/enter_school_controller.dart';
import 'enter_school_index_view.dart';

class EnterSchoolView extends GetView<EnterSchoolController> {
  const EnterSchoolView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '智慧入校',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              height: 60.h,
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: '',
                      children: [
                        TextSpan(
                          text: '您当前的岗位是：',
                          style: BaseStyle.grayContentStyle,
                        ),
                        TextSpan(
                          text: '教职工',
                          style: BaseStyle.contentStyle,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '切换',
                        style: BaseStyle.schoolContentStyle,
                      ),
                      Icon(
                        Icons.expand_more,
                        color: SchoolConfig.primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '学校应用',
                style: BaseStyle.grayContentStyle,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              height: 75.h,
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.w,
                  ),
                  InkWell(
                    child: columnApp(IconFont.icon_fangzi, '入校申请'),
                    onTap: () {
                      Get.to(() => EnterSchoolIndexView(),
                          binding: EnterSchoolIndexBinding());
                    },
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  columnApp(IconFont.icon_gengduo, '更多功能'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget columnApp(IconData iconData, String name) {
    return Column(
      children: [
        Container(
          height: 30.h,
          width: 30.w,
          child: Icon(
            iconData,
            color: SchoolConfig.primaryColor,
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          name,
          style: BaseStyle.smallStyle,
        ),
      ],
    );
  }
}
