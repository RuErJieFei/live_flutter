import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_write_controller.dart';

class SurveyWriteView extends GetView<SurveyWriteController> {
  const SurveyWriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('填写'),
        centerTitle: true,
      ),
      body: Container(
        child: controller.writeSurveyList.length == 0
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
                        '暂无要填写的问卷',
                        style: BaseStyle.grayContentStyle,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                child: Container(
                child: Text('内容'),
              )
                //   Obx(() {
                //   return ReorderableListView(
                //     // padding: const EdgeInsets.symmetric(horizontal: 40),
                //     children: <Widget>[
                //       for (int index = 0;
                //           index < controller.writeSurveyList.length;
                //           index++)
                //         ListTile(
                //           key: Key('$index'),
                //           tileColor: controller.writeSurveyList[index].isOdd
                //               ? Colors.red
                //               : Colors.green,
                //           title:
                //               Text('Item ${controller.writeSurveyList[index]}'),
                //         ),
                //     ],
                //     onReorder: (int oldIndex, int newIndex) {
                //       if (oldIndex < newIndex) {
                //         newIndex -= 1;
                //       }
                //       final int item =
                //           controller.writeSurveyList.removeAt(oldIndex);
                //       controller.writeSurveyList.insert(newIndex, item);
                //     },
                //   );
                // })
                ),
      ),
    );
  }
}
