import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/bench/bindings/enter_school_detail_binding.dart';
import 'package:wit_niit/app/modules/bench/views/enter_school_detail_view.dart';

import '../../../component/choice_chip_multiple.dart';
import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';
import '../controllers/enter_school_history_controller.dart';

class EnterSchoolHistoryView extends GetView<EnterSchoolHistoryController> {
  const EnterSchoolHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          '历史记录',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10.r),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
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
                        width: 10.w,
                      ),
                      Text(
                        '教职工入校申请',
                        style: BaseStyle.fs16bold,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '起止时间：2022-10-09～2022-12-09',
                    style: BaseStyle.graySmallStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Material(
              child: _buildTabBar(),
              color: SchoolConfig.primarySwatchColor.shade50,
            ),
            Expanded(
              flex: 1,
              child: _buildTableBarView(),
            )
          ],
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      //设置为false tab 将平分宽度，为true tab 将会自适应宽度
      isScrollable: false,
      //设置tab文字得类型
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      //设置tab选中得颜色
      labelColor: SchoolConfig.primaryColor,
      //设置tab未选中得颜色
      unselectedLabelColor: Colors.black,
      //设置自定义tab的指示器，CustomUnderlineTabIndicator
      //若不需要自定义，可直接通过
      //设置指示器颜色
      //设置指示器颜色
      indicatorColor: SchoolConfig.primaryColor,
      //indicatorWight 设置指示器厚度
      indicatorPadding: EdgeInsets.only(left: 10, right: 10),
      indicatorWeight: 1.5,

      ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
      indicatorSize: TabBarIndicatorSize.tab,
      controller: controller.tabController,
      tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  Widget _buildTableBarView() => TabBarView(
        controller: controller.tabController,
        children: controller.tabs
            .map(
              (e) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Obx(
                        () => Wrap(
                          // 使用迭代器的方法生成list
                          children: controller.authorities
                              .map(
                                (item) => ChoiceChipSelect(
                                  index: item == '全部'
                                      ? 0
                                      : item == '无风险'
                                          ? 1
                                          : item == '有风险'
                                              ? 2
                                              : 3,
                                  choice: item,
                                  selected: controller.selected.value,
                                  fun: (bool value) {
                                    controller.selected.value = item == '全部'
                                        ? 0
                                        : item == '无风险'
                                            ? 1
                                            : item == '有风险'
                                                ? 2
                                                : 3;
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '共计',
                            style: BaseStyle.contentStyle,
                          ),
                          TextSpan(
                            text: '3',
                            style: BaseStyle.schoolContentStyle,
                          ),
                          TextSpan(
                            text: '条',
                            style: BaseStyle.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    Card('陈蓉琪', '2000100193', '2022-10-25', 0),
                    Divider(),
                    Card('陈蓉琪', '2000100193', '2022-10-25', 0),
                  ],
                ),
              ),
            )
            .toList(),
      );

  Widget Card(String name, String id, String date, int status) {
    return ListTile(
      contentPadding: EdgeInsets.all(4.0),
      isThreeLine: true,
      leading: Container(
        width: 55.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://tva1.sinaimg.cn/large/008vxvgGgy1h85rjouowrj302k03a0si.jpg',
            ),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      title: Row(
        children: <Widget>[
          Text(
            name,
            style: BaseStyle.smallBBoldStyle,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            'ID: $id',
            style: BaseStyle.graySmallStyle,
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel,
                color: Colors.grey.shade700,
                size: 16.0,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                status == 0 ? '【无风险】' : '【有风险】',
                style: BaseStyle.schoolSmallStyle,
              ),
              Text(
                date,
                style: BaseStyle.graySmallStyle,
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Icon(
                Icons.assured_workload,
                color: Colors.grey.shade700,
                size: 16.0,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                '申请【$date】入校',
                style: BaseStyle.graySmallStyle,
              ),
            ],
          ),
        ],
      ),
      trailing: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://tva1.sinaimg.cn/large/008vxvgGgy1h85rdt7lobj303y03yweb.jpg',
            ),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onTap: () {
        Get.to(() => EnterSchoolDetailView(),
            binding: EnterSchoolDetailBinding());
      },
    );
  }
}
