import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_gradinent.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_edit_controller.dart';
import 'package:wit_niit/app/modules/survey/model/template_model.dart';

class SurveyEditView extends GetView<SurveyEditController> {
  const SurveyEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TemplateModel data = Get.arguments ?? TemplateModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 80.h),
                child: Column(
                  children: <Widget>[
                    // 问卷标题
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(fontSize: 36.sp),
                            maxLines: 2,
                            minLines: 1,
                            initialValue: '${formatDate(
                              DateTime.now(),
                              [mm, '月', dd, '日'],
                              locale: SimplifiedChineseDateLocale(),
                            )}${data.content?.title ?? ''}',
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '请添加标题',
                            ),
                          ),
                          TextFormField(
                            initialValue: data.content?.description ?? '',
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '请添加问卷描述文字',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // 问卷题目
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: Get.width,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      initialValue: data.content
                                              ?.queContentList?[index].title ??
                                          '',
                                      style: TextStyle(fontSize: 20.sp),
                                      decoration: InputDecoration(
                                        prefix: Wrap(
                                          children: [
                                            // 是否必填
                                            Text(
                                              data
                                                          .content
                                                          ?.queContentList?[
                                                              index]
                                                          .isRequire ==
                                                      1
                                                  ? '*'
                                                  : '',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            // 序号
                                            Text((data
                                                        .content
                                                        ?.queContentList?[index]
                                                        .queOrder)! <
                                                    10
                                                ? '0${(data.content?.queContentList?[index].queOrder).toString()}'
                                                : (data
                                                        .content
                                                        ?.queContentList?[index]
                                                        .queOrder)
                                                    .toString()),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                          ],
                                        ),
                                        border: InputBorder.none,
                                        hintText: '请输入问题',
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: data.content
                                          ?.queContentList?[index].description,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '添加问题描述文字',
                                      ),
                                    ),
                                    data.content?.queContentList?[index].type ==
                                            2
                                        ? TextFormField(
                                            style: TextStyle(fontSize: 20.sp),
                                            decoration: InputDecoration(
                                              enabled: false,
                                              hintText: '待填写者填写',
                                              border: OutlineInputBorder(),
                                            ),
                                          )
                                        :
                                        // Column(
                                        //         children: [
                                        //           RadioListTile(
                                        //               value: 0,
                                        //               groupValue: 1,
                                        //               title: Text(
                                        //                   '${data.content?.queContentList?[index].queOptions}'),
                                        //               onChanged: (v) {}),
                                        //           RadioListTile(
                                        //               value: 1,
                                        //               groupValue: 1,
                                        //               onChanged: (v) {}),
                                        //         ],
                                        //       )
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data
                                                .content
                                                ?.queContentList?[index]
                                                .queOptions
                                                ?.length,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, i) {
                                              return
                                                  // RadioListTile(
                                                  //   value: 0,
                                                  //   groupValue: 1,
                                                  //   title: Text(
                                                  //       '${data.content?.queContentList?[index].queOptions?[i].answer}'),
                                                  //   onChanged: (v) {});
                                                  ListTile(
                                                title: TextFormField(
                                                  initialValue:
                                                      '${data.content?.queContentList?[index].queOptions?[i].answer}',
                                                  style: TextStyle(
                                                      fontSize: 20.sp),
                                                  decoration: InputDecoration(
                                                    hintText: '选项${i + 1}',
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                                leading: Icon(Icons
                                                    .remove_circle_outline),
                                                trailing: Icon(
                                                    Icons.more_vert_outlined),
                                              );
                                            })
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemCount: (data.content?.queContentList?.length)!),
                    SizedBox(
                      height: 10.h,
                    ),
                    // 添加题目
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
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
                            color: Config.mainColor,
                          ),
                          Text(
                            '插入问题',
                            style: TextStyle(color: Config.mainColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5.h,
              child: BGGradient(
                alignment: Alignment.center,
                width: Get.width * 0.8,
                height: Get.width / 8,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Text(
                  '发布',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
