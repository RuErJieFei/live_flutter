/// FileName enter_school_detail_view
///
/// @Author chenrongqi
/// @Date 2022/11/15 13:57
///
/// @Description TODO
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/current_time.dart';
import '../../../../data/base_style.dart';
import '../../../../data/school_theme_data.dart';
import '../../controllers/enter_school/enter_school_detail_controller.dart';

class EnterSchoolDetailView extends GetView<EnterSchoolDetailController> {
  const EnterSchoolDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '申请详情',
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
          color: SchoolConfig.primaryColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.r),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: SchoolConfig.primarySwatchColor.shade50,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '1',
                          style: BaseStyle.schoolBoldBigContentStyle),
                      TextSpan(
                          text: '  /  2',
                          style: BaseStyle.grayBoldBigContentStyle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TimerWidget(),
                SizedBox(
                  height: 10.0,
                ),
                Image.network(
                  'https://tva1.sinaimg.cn/large/008vxvgGgy1h85sfues11j30u00tdjtp.jpg',
                  width: 280.w,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '- 入校码已过期 -',
                  style: BaseStyle.grayContentStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'o—— 个人信息 ——o',
                        style: BaseStyle.schoolContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('姓名', '陈蓉琪'),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('学工号', '210501100117'),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '手机号',
                        '188********',
                        textStyle: BaseStyle.schoolContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('身份证号', '430426************'),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('部门', '计算机与软件学院'),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'o—— 申请详情 ——o',
                        style: BaseStyle.schoolContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              '申请入校日期:',
                              style: BaseStyle.grayCContentStyle,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              '2022-11-13',
                              style: BaseStyle.fs16bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '审批状态',
                        '已批准',
                        textStyle: BaseStyle.schoolS4ContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('审批时间', '2022-11-13 18：53：16'),
                      SizedBox(
                        height: 10.0,
                      ),
                      column('审批人', '自动审批'),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '风险检测',
                        '无风险',
                        textStyle: BaseStyle.schoolS4ContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '行程范围',
                        '仅市内',
                        textStyle: BaseStyle.schoolS4ContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '核酸检测',
                        '阴性（48小时）',
                        textStyle: BaseStyle.schoolS4ContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      column(
                        '申请时间',
                        '2022-11-13 17：21：57',
                        textStyle: BaseStyle.schoolS4ContentStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget column(String name, String value, {TextStyle? textStyle}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$name:',
            style: BaseStyle.grayCContentStyle,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: textStyle ?? BaseStyle.contentStyle,
          ),
        ),
      ],
    );
  }
}
