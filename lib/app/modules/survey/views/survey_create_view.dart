import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/survey/bindings/survey_edit_binding.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_create_controller.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';
import 'package:wit_niit/app/modules/survey/views/survey_edit_view.dart';

class SurveyCreateView extends GetView<SurveyCreateController> {
  const SurveyCreateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新建'),
        centerTitle: true,
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '新建',
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Wrap(
                          spacing: 5.w,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.orange,
                            ),
                            Text('创建问卷'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Wrap(
                          spacing: 5.w,
                          children: [
                            Icon(
                              Icons.layers_outlined,
                              color: Colors.grey,
                            ),
                            Text('我的模板'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text('常用模板'),
              Obx(() {
                return GridView.custom(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ItemView(controller.templateList[index]);
                      },
                      childCount: controller.templateList.length,
                    ));
              })
            ],
          ),
        ),
      )),
    );
  }
}

class ItemView extends GetView<SurveyCreateController> {
  TemplateModel itemEntity;

  ItemView(this.itemEntity);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 60,
                color: Colors.grey,
              ),
              Text(
                itemEntity.content?.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        onTap: () {
          controller.setTemplate(itemEntity);
          Get.to(() => SurveyEditView(), binding: SurveyEditBinding());
        });
  }
}
