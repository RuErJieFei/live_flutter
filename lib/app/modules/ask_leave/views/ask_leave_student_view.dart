import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:wit_niit/app/modules/ask_leave/controllers/ask_leave_student_controller.dart';
import 'package:wit_niit/app/modules/ask_leave/widget/basic_info_tile.dart';

class AskLeaveStudentView extends GetView<AskLeaveStudentController> {
  const AskLeaveStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('请假-学生请假'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "基础信息",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: 0.35.sh,
                      child: ListView.builder(
                        itemCount: controller.keys.length,
                        itemBuilder: (_, int index) => Obx(() {
                          return BasicInfoTile(
                              title: controller.keys[index],
                              content: controller.values[index]);
                          // return ListTile(
                          //   title: Text(
                          //     controller.keys[index],
                          //     maxLines: 1,
                          //   ),
                          //   trailing: Text(
                          //     controller.values[index],
                          //     maxLines: 1,
                          //     textAlign: TextAlign.left,
                          //   ),
                          // );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                child: Text(
                  "请假信息",
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              Container(
                // width: double.infinity,
                // height: 800.h,
                decoration: BoxDecoration(color: Colors.white),
                child: ReactiveFormBuilder(
                  form: controller.buildForm,
                  builder: (_, form, child) {
                    return Column(
                      children: [
                        ReactiveDropdownField(
                          formControlName: 'type',
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.star, color: Colors.red, size: 8.sp),
                                Text("请假类型", style: TextStyle(fontSize: 16.sp))
                              ],
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                                value: "顶岗实习", child: Text('顶岗实习')),
                            DropdownMenuItem(
                                value: "病假（离宁）", child: Text('病假（离宁）')),
                            DropdownMenuItem(
                                value: "病假（不离宁，占课）", child: Text('病假（不离宁，占课）')),
                            DropdownMenuItem(
                                value: "病假（不离宁，不占课）",
                                child: Text('病假（不离宁，不占课）')),
                            DropdownMenuItem(
                                value: "事假（离宁）", child: Text('事假（离宁）')),
                            DropdownMenuItem(
                                value: "事假（不离宁，占课）", child: Text('事假（不离宁，占课）')),
                            DropdownMenuItem(
                                value: "事假（不离宁，不占课）",
                                child: Text('事假（不离宁，不占课）')),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                              child: Text(
                                "说明",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                                child: Text.rich(TextSpan(
                                  text: "1、请选择",
                                  children: [
                                    TextSpan(
                                        text: "请假开始时间",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(text: "和"),
                                    TextSpan(
                                        text: "请假结束时间",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(text: "，且结束时间要迟于开始时间；"),
                                  ],
                                  style: TextStyle(fontSize: 14.sp),
                                ))),
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                                child: Text.rich(TextSpan(
                                  text: "2、",
                                  children: [
                                    TextSpan(
                                        text: "请假总天数",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(text: "按照"),
                                    TextSpan(
                                        text: "自然天",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(
                                        text:
                                            "计算，时长不足12小时按半天计算，时长超过当天12小时，请假天数按一天计算，以此类推计算；"),
                                  ],
                                  style: TextStyle(fontSize: 14.sp),
                                ))),
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
                                child: Text.rich(TextSpan(
                                  text: "3、",
                                  children: [
                                    TextSpan(
                                        text: "请假结束时间",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(text: "即为"),
                                    TextSpan(
                                        text: "销假时间",
                                        style: TextStyle(color: Colors.red)),
                                    TextSpan(text: "，请在此时间前销假。"),
                                  ],
                                  style: TextStyle(fontSize: 14.sp),
                                ))),
                          ],
                        ),
                        ReactiveDateTimePicker(
                          formControlName: "applicationTime",
                          type: ReactiveDatePickerFieldType.dateTime,
                          dateFormat: DateFormat("yyyy-MM-dd HH:mm"),
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.star, color: Colors.red, size: 8.sp),
                                Text("请假开始时间",
                                    style: TextStyle(fontSize: 16.sp))
                              ],
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ReactiveDateTimePicker(
                          formControlName: 'deadline',
                          type: ReactiveDatePickerFieldType.dateTime,
                          dateFormat: DateFormat("yyyy-MM-dd HH:mm"),
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.star, color: Colors.red, size: 8.sp),
                                Text("请假结束时间",
                                    style: TextStyle(fontSize: 16.sp))
                              ],
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        // 请假天数
                        ReactiveTextField(
                          formControlName: 'days',
                          decoration: InputDecoration(labelText: "请假天数"),
                          keyboardType: TextInputType.number,
                          readOnly: true,
                        ),
                        ReactiveFormConsumer(
                          builder: (context, form, child) {
                            if (form.control("applicationTime").value != null &&
                                form.control("deadline").value != null) {
                              controller.calculateDiffer(form);
                            } else {
                              form.control("days").value = null;
                            }
                            return Container();
                          },
                        ),
                        ReactiveDropdownField(
                          formControlName: 'overnight',
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(Icons.star, color: Colors.red, size: 8.sp),
                                Text("是否校内住宿",
                                    style: TextStyle(fontSize: 16.sp))
                              ],
                            ),
                          ),
                          items: [
                            DropdownMenuItem(value: true, child: Text('是')),
                            DropdownMenuItem(value: false, child: Text('否')),
                          ],
                        ),


                        ElevatedButton(
                            onPressed: () => controller.onSubmit(form.value),
                            child: Text("提交"))
                        // ReactiveDatePicker<DateTime>(
                        //   formControlName: 'applicationTime',
                        //   firstDate: DateTime(1985),
                        //   lastDate: DateTime(2030),
                        //   builder: (context, picker, child) {
                        //     Widget suffix = InkWell(
                        //       onTap: () {
                        //         // workaround until https://github.com/flutter/flutter/issues/39376
                        //         // will be fixed
                        //
                        //         // Unfocus all focus nodes
                        //         controller.focusNode.unfocus();
                        //
                        //         // Disable text field's focus node request
                        //         controller.focusNode.canRequestFocus = false;
                        //
                        //         // clear field value
                        //         picker.control.value = null;
                        //
                        //         //Enable the text field's focus node request after some delay
                        //         Future.delayed(const Duration(milliseconds: 100), () {
                        //           controller.focusNode.canRequestFocus = true;
                        //         });
                        //       },
                        //       child: const Icon(Icons.clear),
                        //     );
                        //
                        //     if (picker.value == null) {
                        //       suffix = const Icon(Icons.calendar_today);
                        //     }
                        //
                        //     return ReactiveTextField(
                        //       onTap: (_) {
                        //         if (controller.focusNode.canRequestFocus) {
                        //           controller.focusNode.unfocus();
                        //           picker.showPicker();
                        //         }
                        //       },
                        //       valueAccessor: DateTimeValueAccessor(
                        //         dateTimeFormat: DateFormat('yyyy-MM-dd HH:mm'),
                        //       ),
                        //       focusNode: controller.focusNode,
                        //       formControlName: 'applicationTime',
                        //       readOnly: true,
                        //       decoration: InputDecoration(
                        //         label: Row(
                        //           children: [
                        //             Icon(Icons.star, color: Colors.red, size: 8.sp),
                        //             Text("请假开始日期", style: TextStyle(fontSize: 16.sp))
                        //           ],
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
