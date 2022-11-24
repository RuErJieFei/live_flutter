import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_analysis_controller.dart';

class SurveyAnalysisView extends GetView<SurveyAnalysisController> {
  const SurveyAnalysisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计'),
        centerTitle: true,
      ),
      body: Container(
        child: controller.analysisSurveyList.length == 0
            ? Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.grey,
                        size: 60,
                      ),
                      Text(
                        '暂无可查看的统计',
                        style: BaseStyle.grayContentStyle,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                child: Text('内容'),
              ),
      ),
    );
  }
}
