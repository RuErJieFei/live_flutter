import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/personal/bindings/personal_status_binding.dart';
import 'package:wit_niit/app/modules/personal/views/personal_status_view.dart';
import 'package:wit_niit/app/routes/app_pages.dart';

import '../controllers/personal_controller.dart';

class PersonalView extends GetView<PersonalController> {
  const PersonalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景色
      backgroundColor: BaseData.kBackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: '返回上一页',
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black87,
            size: 32,
          ),
          onPressed: () => Get.offAllNamed(Routes.INDEX),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Semantics(
                    label: '单击进入个人信息页面',
                    child: InkWell(
                      // 命名路由跳转
                      onTap: () => Get.toNamed(('/personal/info')),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5.w,
                                  children: [
                                    Text(
                                      'AI南工',
                                      style: BaseStyle.grayContentStyle,
                                      semanticsLabel: '所在企业：AI南工',
                                    ),
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Obx(() {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      '${controller.user.value.photo}',
                                      width: 64.w,
                                      height: 64.w,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                })
                              ],
                            ),
                            Obx(() {
                              return Text(
                                '${controller.user.value.name}',
                                semanticsLabel:
                                    '用户名称：${controller.user.value.name}',
                                style: TextStyle(fontSize: 20.sp),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 0,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => PersonalStatusView(),
                        binding: PersonalStatusBinding()),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      width: Get.width,
                      child: Wrap(
                        spacing: 10.w,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.add_reaction_outlined,
                            size: 14,
                            color: Colors.grey,
                          ),
                          Text(
                            '添加个人状态...',
                            style: BaseStyle.graySmallStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(Get.width / 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              color: Config.mainColor,
                            ),
                            Text(
                              '收藏',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.white,
                      // ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(Get.width / 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Config.mainColor,
                            ),
                            Text(
                              '通勤',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
