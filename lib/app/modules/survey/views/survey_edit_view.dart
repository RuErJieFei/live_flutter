import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_gradinent.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/survey/controllers/survey_edit_controller.dart';

class SurveyEditView extends GetView<SurveyEditController> {
  const SurveyEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TemplateModel data = Get.arguments ?? TemplateModel();
    // var data = TemplateModel().obs;
    // data.value = Get.arguments ?? TemplateModel();

    return Scaffold(
        appBar: AppBar(
          title: const Text('校园问卷'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        body: Column(
          children: [
            Material(
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.black87,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child:
                  TabBarView(controller: controller.tabController, children: [
                buildEditView(),
                buildSettingView(context),
              ]),
            ),
          ],
        ));
  }

  Widget buildSettingView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Obx(() {
                  return ListTile(
                    onTap: () {},
                    title: Text('谁可以填'),
                    subtitle:
                        Text(controller.whoCanWrite.length != 0 ? '' : '所有人'),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Obx(() {
                  return ListTile(
                    title: Text('允许每人提交多份'),
                    trailing: CupertinoSwitch(
                      activeColor: Config.mainColor,
                      trackColor: Config.mainColor.withOpacity(0.3),
                      value: controller.isMultiple.value,
                      onChanged: (v) => controller.changeIsMultiple(v),
                    ),
                  );
                }),
                Divider(),
                Obx(() {
                  return ListTile(
                    title: Text('允许填写人修改结果'),
                    trailing: CupertinoSwitch(
                      activeColor: Config.mainColor,
                      trackColor: Config.mainColor.withOpacity(0.3),
                      value: controller.isAllowEdit.value,
                      onChanged: (v) => controller.changeIsAllowEdit(v),
                    ),
                  );
                }),
                Divider(),
                Obx(() {
                  return ListTile(
                    title: Text('匿名填写'),
                    trailing: CupertinoSwitch(
                      activeColor: Config.mainColor,
                      trackColor: Config.mainColor.withOpacity(0.3),
                      value: controller.isNotKnow.value,
                      onChanged: (v) => controller.changeIsNotKnow(v),
                    ),
                  );
                }),
                Divider(),
                ListTile(
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        maxTime: DateTime(2050, 12, 1),
                        minTime: DateTime(2020, 1, 1),
                        theme: DatePickerTheme(
                            itemStyle: TextStyle(
                                color: Config.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(fontSize: 16)),
                        onChanged: (date) {
                      // print('change $date in time zone ' +
                      //     date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      controller.endDateTime.value = date;
                      // print('confirm $date');
                    }, currentTime: DateTime.now(), locale: LocaleType.zh);
                  },
                  title: Text('设置截止时间'),
                  subtitle: Obx(() {
                    return Text("${formatDate(controller.endDateTime.value, [
                          mm,
                          "月",
                          dd,
                          "日     ",
                          HH,
                          ":",
                          nn
                        ])}");
                  }),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: () {},
                  title: Text('可查看收集结果的人'),
                  subtitle:
                      Text(controller.whoCanLookRes.length != 0 ? 'zk' : ''),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Get.bottomSheet(Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: Get.width,
                            child: Text(
                              '新提交结果通知频率',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                          ),
                          Obx(() {
                            return ListView.builder(
                                itemCount: controller.remindList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading:
                                        controller.remindList[index].isSelect ==
                                                true
                                            ? Icon(Icons.check,
                                                color: Config.mainColor)
                                            : Container(
                                                width: 1.w,
                                              ),
                                    title: Text(controller
                                        .remindList[index].genderName),
                                    onTap: () => controller.changeRemindType(
                                        controller.remindList[index]),
                                  );
                                });
                          })
                        ],
                      ),
                    ));
                  },
                  title: Container(
                    child: Text(
                      '提交结果提醒',
                    ),
                  ),
                  trailing: Wrap(
                    spacing: 5.w,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Obx(() {
                        return Text(controller.remind.value);
                      }),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditView() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Obx(() {
              return Container(
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
                            )}${controller.data.value.content?.title ?? ''}',
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '请添加标题',
                            ),
                          ),
                          TextFormField(
                            initialValue:
                                controller.data.value.content?.description ??
                                    '',
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
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          key: Key('$index'),
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
                                    initialValue: controller.data.value.content
                                            ?.queContentList?[index].title ??
                                        '',
                                    style: TextStyle(fontSize: 20.sp),
                                    decoration: InputDecoration(
                                      prefix: Wrap(
                                        children: [
                                          // 是否必填
                                          Text(
                                            controller
                                                        .data
                                                        .value
                                                        .content
                                                        ?.queContentList?[index]
                                                        .isRequire ==
                                                    1
                                                ? '*'
                                                : '',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          // 序号
                                          Text((index + 1) < 10
                                              ? '0${(index + 1)}'
                                              : '${index + 1}'),
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
                                    initialValue: controller.data.value.content
                                        ?.queContentList?[index].description,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '添加问题描述文字',
                                    ),
                                  ),
                                  controller.data.value.content
                                              ?.queContentList?[index].type ==
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
                                      //                   '${data.value.content?.queContentList?[index].queOptions}'),
                                      //               onChanged: (v) {}),
                                      //           RadioListTile(
                                      //               value: 1,
                                      //               groupValue: 1,
                                      //               onChanged: (v) {}),
                                      //         ],
                                      //       )
                                      ReorderableListView.builder(
                                          shrinkWrap: true,
                                          itemCount: (controller
                                              .data
                                              .value
                                              .content
                                              ?.queContentList?[index]
                                              .queOptions
                                              ?.length)!,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return
                                                // RadioListTile(
                                                //   value: 0,
                                                //   groupValue: 1,
                                                //   title: Text(
                                                //       '${data.value.content?.queContentList?[index].queOptions?[i].answer}'),
                                                //   onChanged: (v) {});
                                                ListTile(
                                              key: Key('$i'),
                                              title: TextFormField(
                                                initialValue:
                                                    '${controller.data.value.content?.queContentList?[index].queOptions?[i].answer}',
                                                style:
                                                    TextStyle(fontSize: 20.sp),
                                                decoration: InputDecoration(
                                                  hintText: '选项${i + 1}',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                              leading: Icon(
                                                  Icons.remove_circle_outline),
                                              trailing: Icon(
                                                  Icons.more_vert_outlined),
                                            );
                                          },
                                          onReorder:
                                              (int oldIndex, int newIndex) {
                                            if (oldIndex < newIndex) {
                                              newIndex -= 1;
                                            }
                                            controller.renderOptionList(
                                                index, oldIndex, newIndex);
                                          },
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        );
                      },
                      // separatorBuilder: (context, index) {
                      //   return SizedBox(
                      //     height: 10.h,
                      //   );
                      // },
                      itemCount: (controller
                          .data.value.content?.queContentList?.length)!,
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        controller.renderList(oldIndex, newIndex);
                      },
                    ),
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
              );
            }),
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
    );
  }
}
