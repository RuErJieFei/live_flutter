import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bench_controller.dart';

class BenchView extends GetView<BenchController> {
  const BenchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BenchView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BenchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
