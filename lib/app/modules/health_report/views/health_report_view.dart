import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        backgroundColor: SchoolConfig.primarySwatchColor.shade400,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: new BoxDecoration(
            color: SchoolConfig.primarySwatchColor.shade800,
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
                      color: SchoolConfig.primarySwatchColor.shade500,
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
                      color: SchoolConfig.primarySwatchColor.shade700,
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
                      child: formBorder('江苏省南京市栖霞区', false, showSelect: true),
                      onTap: () {
                        controller.getResult(context);
                      },
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
        color: SchoolConfig.primarySwatchColor.shade800,
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
            ? SchoolConfig.primarySwatchColor.shade800
            : SchoolConfig.primarySwatchColor.shade900,
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
}
