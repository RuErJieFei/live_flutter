import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_container.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('邮件'),
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
        defaultType: 2,
      ),
    );
  }
}
