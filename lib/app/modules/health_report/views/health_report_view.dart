import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/health_report_controller.dart';

class HealthReportView extends GetView<HealthReportController> {
  const HealthReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthReportView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HealthReportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
