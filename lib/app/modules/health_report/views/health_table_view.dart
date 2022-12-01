import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/data_table_source.dart';
import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';
import '../controllers/health_table_controller.dart';

TextStyle textStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontSize: 14.sp,
);

TextStyle textBoldStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

class HealthTableView extends GetView<HealthTableController> {
  const HealthTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '【健康上报】在校学生',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primarySwatchColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: Column(
          children: [
            Obx(() {
              LogUtil.v('>>>>>>>>>>>>>>>>>>>>');
              LogUtil.v(controller.healthList);
              return PaginatedDataTable(
                header: Text('学生健康上报记录'),
                columns: [
                  DataColumn(label: Text('填报时间')),
                  DataColumn(label: Text('姓名')),
                  DataColumn(label: Text('学号')),
                  DataColumn(label: Text('所在班级')),
                  DataColumn(label: Text('手机号码')),
                  DataColumn(label: Text('所属学院')),
                  DataColumn(label: Text('当前定位')),
                  DataColumn(label: Text('档案生源地信息')),
                  DataColumn(label: Text('是否有十大症状')),
                  DataColumn(label: Text('本人及家属是否疑似感染新冠')),
                  DataColumn(label: Text('本人及家属是否确诊感染新冠')),
                ],
                source: MyDataTableSource(controller.healthList),
              );
            })
          ],
        ),
      ),
    );
  }
}
