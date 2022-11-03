import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_container.dart';
import 'package:wit_niit/app/component/my_Botton.dart';
import 'package:wit_niit/app/component/my_text_field.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/home/controllers/home_controller.dart';
import 'package:wit_niit/app/routes/app_pages.dart';
import 'package:wit_niit/main.dart';

class HomeView extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() {
          return Text('${controller.count}');
        }),
        centerTitle: true,
        actions: [
          InkWell(
            child: Icon(Icons.dark_mode_outlined),
            onTap: () => Get.changeTheme(Get.isDarkMode ? defaultTheme : appDarkTheme),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: BGContainer(
        // defaultType: 0, // 默认0、 1加载中、 2 暂无数据、 3网络加载失败
        child: Column(
          children: [
            Text(
              'HomeView is working~~~',
              style: BaseStyle.wdStyle,
            ),
            ElevatedButton(
              onPressed: () {
                EasyLoading.showToast('hello～～');
              },
              child: Text('秀吐司'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    onConfirm: () => Get.back(),
                    onCancel: () => {},
                    middleText: "Dialog made in ... lines of code");
              },
              child: Text('鹅勒特'),
            ),
            MyTextField(),
            Divider(),
            MyButton(
              onTap: () {
                LogUtil.v('小吃吧');
                Get.snackbar('小吃吧', 'snackBar');
              },
              title: '小吃吧',
            ),
            SizedBox(height: 30),
            MyButton(
                onTap: () {
                  Get.bottomSheet(
                      Container(
                        child: Wrap(children: <Widget>[
                          ListTile(
                              leading: Icon(Icons.music_note),
                              title: Text('Music'),
                              onTap: () {
                                Get.back();
                              }),
                          ListTile(
                            leading: Icon(Icons.videocam),
                            title: Text('Video'),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ]),
                      ),
                      backgroundColor: Colors.white);
                },
                title: 'bottomSheet'),
            ElevatedButton(onPressed: () => Get.toNamed(Routes.LOGIN), child: Text('去登录'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.increment();
          Map<String, dynamic> params = {"type": "敏捷开发", "content": "有一个能跑就行"};
          request.get('/get', params: params).then((value) => LogUtil.v(value)).catchError((_) {
            EasyLoading.showError('数据解析异常');
          });
        },
      ),
    );
  }
}
