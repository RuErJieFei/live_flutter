import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/micro_disk_controller.dart';

class MicroDiskView extends GetView<MicroDiskController> {
  const MicroDiskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MicroDiskView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MicroDiskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
