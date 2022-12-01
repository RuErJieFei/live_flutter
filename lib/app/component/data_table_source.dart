import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/login/model/user_model.dart';

/// FileName data_table_source
///
/// @Author chenrongqi
/// @Date 2022/11/30 17:10
///
/// @Description TODO
class MyDataTableSource extends DataTableSource {
  MyDataTableSource(this.data);

  final List data;

  @override
  DataRow? getRow(int index) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    if (index >= data.length) {
      return null;
    }
    LogUtil.v('||||||||||||||||||||||||||');
    LogUtil.v(data[index].updatedTime);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].updatedTime}')),
        DataCell(Text('${user?.name}')),
        DataCell(Text('${data[index].userId}')),
        DataCell(Text('${user?.classes}')),
        DataCell(Text('${user?.phone}')),
        DataCell(Text('${user?.college}')),
        DataCell(Text('${data[index].position}')),
        DataCell(Text('${data[index].address}')),
        DataCell(tag(data[index].isSymptom10 == '0' ? '无' : '有',
            data[index].isSymptom10 == '0' ? false : true)),
        DataCell(tag(data[index].isSuspectedCovid19 == '0' ? '无' : '有',
            data[index].isSuspectedCovid19 == '0' ? false : true)),
        DataCell(tag(data[index].isConfirmedCovid19 == '0' ? '无' : '有',
            data[index].isConfirmedCovid19 == '0' ? false : true)),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
        // DataCell(Text('${data[index].address}')),
      ],
    );
  }

  Widget tag(String content, bool isTrue) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: isTrue ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        content,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
    );
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return data.length;
  }
}
