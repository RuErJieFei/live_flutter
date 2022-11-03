import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/home/controllers/home_controller.dart';
import 'package:wit_niit/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var c = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'LoginView is working',
              style: TextStyle(fontSize: 20),
            ),
            Text('${controller.username}'),
            Text('${c.count}'),
          ],
        ),
      ),
    );
  }
}
