import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/controllers/bench_controller.dart';

/// 工作台
class BenchView extends GetView<BenchController> {
  const BenchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('工作台'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.edit_road),
              onPressed: () {
                LogUtil.v('编辑工作台');
                EasyLoading.showToast('${(2 / 3).ceil()}');
              },
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xfff2f2f2),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _card(context, '抗疫专区', controller.epidemic),
              _card(context, '信息中心', controller.information),
              _card(context, '办事中心', controller.work),
              _card(context, '基础功能', controller.basic),
              _card(context, '工具箱', controller.tools),
            ],
          ),
        ),
      ),
    );
  }

  /// 表格布局
  Widget _card(BuildContext context, String title, List<BenchItem> list) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffe7e4e4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              title,
              style: TextStyle(color: Color(0xff838181), fontSize: 15.sp),
            ),
          ),
          SizedBox(height: 1),
          GridView.builder(
            // 包裹
            shrinkWrap: true,
            // 不可滑动
            physics: NeverScrollableScrollPhysics(),
            // 个数, 3的倍数，向上取整
            itemCount: 3 * (list.length / 3).ceil(),
            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // 横轴元素个数
              crossAxisCount: 3,
              // 主轴间距
              mainAxisSpacing: 0.5,
              // 从轴间距
              crossAxisSpacing: 0.5,
              // 子组件宽高长度比例
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (index >= list.length) {
                return Container(color: Colors.white);
              }

              return GestureDetector(
                onTap: () {
                  Get.toNamed(list[index].route);
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        list[index].ImgUrl,
                        height: 50.h,
                      ),
                      SizedBox(height: 10.h),
                      Text(list[index].title),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
