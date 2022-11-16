import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wit_niit/app/modules/personal/controllers/personal_gender_controller.dart';

class PersonalGenderView extends GetView<PersonalGenderController> {
  const PersonalGenderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('性别'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PersonalGenderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
