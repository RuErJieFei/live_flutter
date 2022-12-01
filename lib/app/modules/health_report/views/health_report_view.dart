import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/health_report/bindings/health_report_binding.dart';
import 'package:wit_niit/app/modules/health_report/views/health_table_view.dart';
import 'package:wit_niit/app/modules/health_report/views/location_view.dart';

import '../../../component/school_push_buttton.dart';
import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';
import '../../login/model/user_model.dart';
import '../controllers/health_report_controller.dart';

TextStyle textStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontSize: 14.sp,
);

TextStyle textBoldStyle = TextStyle(
  color: SchoolConfig.primarySwatchColor.shade400,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

class HealthReportView extends GetView<HealthReportController> {
  const HealthReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? user = SpUtil.getObj(
        "user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    return Scaffold(
      appBar: AppBar(
        iconTheme: SchoolConfig.iconTheme,
        title: Text(
          user?.roleList![0] == 'student' ? '【健康上报】在校学生' : '【健康上报】教职员工',
          style: BaseStyle.topStyle,
        ),
        backgroundColor: SchoolConfig.primarySwatchColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: SchoolConfig.primarySwatchColor.shade50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 15.h,
                    color: SchoolConfig.primarySwatchColor.shade800,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 15.h,
                    color: SchoolConfig.primarySwatchColor.shade600,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 15.h,
                    color: SchoolConfig.primarySwatchColor.shade500,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: user?.roleList![0] == 'student'
                      ? FormBuilder(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60.h,
                              ),
                              Text(
                                '每天12:00前填报个人健康情况',
                                style: TextStyle(
                                  color:
                                      SchoolConfig.primarySwatchColor.shade400,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: '个人已提交信息，',
                                    style: TextStyle(
                                      color: SchoolConfig
                                          .primarySwatchColor.shade400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '点我',
                                    style: TextStyle(
                                      color: SchoolConfig.primarySwatchColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => HealthTableView(),
                                            binding: HealthReportBinding());
                                      },
                                  ),
                                  TextSpan(
                                    text: '进入查询',
                                    style: TextStyle(
                                      color: SchoolConfig
                                          .primarySwatchColor.shade400,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Divider(),
                              title('填报时间'),
                              SizedBox(
                                height: 10.h,
                              ),
                              formBorder(controller.getTime(), true),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('姓名'),
                              SizedBox(
                                height: 10.0,
                              ),
                              tagCircle(user?.photo, user?.name),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('所属学院'),
                              SizedBox(
                                height: 10.0,
                              ),
                              tagCircle(
                                  'https://tva1.sinaimg.cn/large/008vxvgGgy1h8g0n7bjq8j301i01kdfl.jpg',
                                  user?.college),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('所在班级'),
                              SizedBox(
                                height: 10.0,
                              ),
                              tagCircle(
                                  'https://tva1.sinaimg.cn/large/008vxvgGgy1h8g0n7bjq8j301i01kdfl.jpg',
                                  user?.classes),
                              SizedBox(
                                height: 20.0,
                              ),
                              title(user?.roleList![0] == 'student'
                                  ? '学号'
                                  : '10位工号'),
                              SizedBox(
                                height: 10.0,
                              ),
                              formBorder(user?.sno, true),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('今天是否在校'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isInSchool.value, 1)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('48小时内是否做过核酸检测'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isTest48.value, 13)),
                              title('当前定位'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '务必',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '赋予'),
                                      TextSpan(
                                          text: '当前软件',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '定位权限'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '一次定位不成功，',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '清空地址'),
                                      TextSpan(
                                          text: '后，可以',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '再次尝试'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '或者打开，',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: 'GPS'),
                                      TextSpan(
                                          text: '，到',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '室外'),
                                      TextSpan(
                                          text: '进行',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '定位'),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(
                                () => controller.locationName.value == ''
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        padding: EdgeInsets.all(10.r),
                                        decoration: BoxDecoration(
                                          color: SchoolConfig
                                              .primarySwatchColor.shade50,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: SchoolConfig
                                                  .primarySwatchColor.shade400
                                                  .withOpacity(0.3),
                                              width: 0.6),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.locationName.value,
                                              style: textBoldStyle,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Divider(),
                                            Text(
                                              '纬度：${controller.longitude.value}，经度：${controller.latitude.value}',
                                              style: BaseStyle.graySmallStyle,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.setLocation(
                                                  '',
                                                  '',
                                                  '',
                                                );
                                              },
                                              child: Text(
                                                '清空',
                                                style: BaseStyle
                                                    .schoolContentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              Obx(
                                () => controller.locationName.value == ''
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          '此项为必填项',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Container(),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var res = await Get.to(() => LocationView());
                                  controller.setLocation(
                                    res['list']['addr'].toString(),
                                    res['longitude'].toString(),
                                    res['latitude'].toString(),
                                  );
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color:
                                        SchoolConfig.primarySwatchColor.shade50,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: SchoolConfig
                                            .primarySwatchColor.shade400
                                            .withOpacity(0.3),
                                        width: 0.6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: SchoolConfig
                                            .primarySwatchColor.shade400
                                            .withOpacity(0.5),
                                      ),
                                      Text(
                                        '选择定位',
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('家庭实际居住地'),
                              SizedBox(
                                height: 10.h,
                              ),
                              GestureDetector(
                                child: Obx(
                                  () => formBorder(
                                      controller.address.value, false,
                                      showSelect: true),
                                ),
                                onTap: () {
                                  controller.getResult(context);
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('是否接种新冠病毒疫苗'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => radioTag(
                                  'green',
                                  ['是,已完成', '是,未完成', '否,未接种'],
                                  controller.isAccinated.value,
                                  14)),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('是否有"十大症状"（填报前24小时内）'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '发热、干咳、乏力、鼻塞、流涕、咽痛、嗅觉/味觉减退、结膜炎、肌痛、腹泻等（简称"十大症状"）',
                                  style: BaseStyle.graySmallStyle,
                                ),
                              ),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isSymptom10.value, 9)),
                              SizedBox(
                                height: 20.0,
                              ),
                              title(
                                  '本人及家属是否疑似感染新型冠状病毒肺炎（经过医院初步诊断，疑似感染新型冠状病毒肺炎）'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isSuspectedCovid19.value, 15)),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('本人及家属是否确诊患新型冠状病毒肺炎'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isConfirmedCovid19.value, 20)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('本人及家属是否经诊断为无症状感染者'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是', '否'],
                                  controller.isAsymptomaticInfection.value,
                                  16)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('本人及家属有无被隔离人员'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isQuarantine.value, 13)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('近期是否途径中高风险地区'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isTransitHignrisk.value, 4)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('近期是否停留中高风险地区'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isStayHignrisk.value, 3)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('近期是否接触停留或途径中高风险地区的人员'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是', '否'],
                                  controller.isContactHighriskPersonnel.value,
                                  5)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('近期本人有无到访境外情况（含港澳台）？'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isGoAbroad.value, 6)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('今天是否接触过有发热或呼吸道感染症状的人'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isContactSickPeople.value, 7)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('辅导员、班主任是否与你联系并及时告知不要提前返校与疫情期间的注意事项等信息？'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是,已联系告知', '否,未联系告知'],
                                  controller.isInformedByTeacher.value,
                                  18)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('你是否对填写内容的真实性负责？'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是', '否'],
                                  controller.isResponsibleForAuthenticity.value,
                                  19)),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                ' 其他需要说明的情况',
                                style: textBoldStyle,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: inputBorder(
                              //       '请填写内容', controller.supplementaryNotes),
                              // ),
                              FormBuilderTextField(
                                // key: controller.formKey,
                                name: 'supplementaryNotes',
                                decoration: const InputDecoration(
                                  labelText: '请填写其他需要说明的情况',
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA5A5A5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(
                                //       errorText: '请准确填写信息'),
                                // ]),
                                onChanged: (e) {
                                  controller.supplementaryNotes.value = e!;
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('信息正常/异常?'),
                              SizedBox(
                                height: 10.h,
                              ),
                              formBorder('正常', false),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        )
                      : FormBuilder(
                          key: controller.formTeacherKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60.h,
                              ),
                              Text(
                                '每天12:00前填报个人健康情况',
                                style: TextStyle(
                                  color:
                                      SchoolConfig.primarySwatchColor.shade400,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Divider(),
                              title('姓名'),
                              SizedBox(
                                height: 10.0,
                              ),
                              tagCircle(user?.photo, user?.name),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('部门（单位）'),
                              SizedBox(
                                height: 10.0,
                              ),
                              tagCircle(
                                  'https://tva1.sinaimg.cn/large/008vxvgGgy1h8g0n7bjq8j301i01kdfl.jpg',
                                  user?.college),
                              user?.roleList![0] == 'student'
                                  ? SizedBox(
                                      height: 20.0,
                                    )
                                  : Container(),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('10位工号'),
                              SizedBox(
                                height: 10.0,
                              ),
                              formBorder(user?.sno, true),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('手机长号'),
                              SizedBox(
                                height: 10.0,
                              ),
                              formBorder(user?.phone, true),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('常住地址'),
                              SizedBox(
                                height: 10.0,
                              ),
                              GestureDetector(
                                child: Obx(
                                  () => formBorder(
                                      controller.address.value, false,
                                      showSelect: true),
                                ),
                                onTap: () {
                                  controller.getResult(context);
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('常住地街道信息'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Image.network(
                                  'https://tva1.sinaimg.cn/large/008vxvgGgy1h8g4at6lscj30fc0g8t9p.jpg'),
                              SizedBox(
                                height: 10.h,
                              ),
                              FormBuilderTextField(
                                // key: controller.formTeacherKey,
                                name: 'addressStreet',
                                decoration: InputDecoration(
                                  labelText: '请填写街道信息',
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA5A5A5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: '请准确填写街道信息'),
                                ]),
                                onChanged: (e) {
                                  controller.addressStreetTf.value = e!;
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('手机定位功能是否正常'),
                              Obx(() => radioTag('green', ['正常', '不正常'],
                                  controller.isLocation.value, 0)),
                              // Obx(() => radioTag('red', '不正常',
                              //     controller.isLocation.value, 1, 0)),
                              SizedBox(
                                height: 10.0,
                              ),
                              title('当前定位'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '务必',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '赋予'),
                                      TextSpan(
                                          text: '当前软件',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '定位权限'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '一次定位不成功，',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '清空地址'),
                                      TextSpan(
                                          text: '后，可以',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '再次尝试'),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '或者打开，',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: 'GPS'),
                                      TextSpan(
                                          text: '，到',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '室外'),
                                      TextSpan(
                                          text: '进行',
                                          style: BaseStyle.graySmallStyle),
                                      TextSpan(text: '定位'),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(
                                () => controller.locationName.value == ''
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        padding: EdgeInsets.all(10.r),
                                        decoration: BoxDecoration(
                                          color: SchoolConfig
                                              .primarySwatchColor.shade50,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: SchoolConfig
                                                  .primarySwatchColor.shade400
                                                  .withOpacity(0.3),
                                              width: 0.6),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.locationName.value,
                                              style: textBoldStyle,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Divider(),
                                            Text(
                                              '纬度：${controller.longitude.value}，经度：${controller.latitude.value}',
                                              style: BaseStyle.graySmallStyle,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.setLocation(
                                                  '',
                                                  '',
                                                  '',
                                                );
                                              },
                                              child: Text(
                                                '清空',
                                                style: BaseStyle
                                                    .schoolContentStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Obx(
                                () => controller.locationName.value == ''
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Text(
                                          '此项为必填项',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : Container(),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var res = await Get.to(() => LocationView());
                                  controller.setLocation(
                                    res['list']['addr'].toString(),
                                    res['longitude'].toString(),
                                    res['latitude'].toString(),
                                  );
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color:
                                        SchoolConfig.primarySwatchColor.shade50,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: SchoolConfig
                                            .primarySwatchColor.shade400
                                            .withOpacity(0.3),
                                        width: 0.6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: SchoolConfig
                                            .primarySwatchColor.shade400
                                            .withOpacity(0.5),
                                      ),
                                      Text(
                                        '选择定位',
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('今天是否到校'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isInSchool.value, 1)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('今天是否入住青教公寓'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isInApartment.value, 2)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('是否去过中高风险地区'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isStayHignrisk.value, 3)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('是否途径中高风险地区'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isTransitHignrisk.value, 4)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('是否接触过去过或者途径中高风险地区的人员'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是', '否'],
                                  controller.isContactHighriskPersonnel.value,
                                  5)),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                '输入型疫情信息采集',
                                style: textBoldStyle,
                              ),
                              Divider(),
                              title('今天本人或家属有无从境外返回'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isGoAbroad.value, 6)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('今天本人是否接触境外返回人员'),
                              Obx(() => radioTag(
                                  'green',
                                  ['是', '否'],
                                  controller.isContactOverseasPersonnel.value,
                                  7)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('今天体温是否正常'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isNormalTemperature.value, 8)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('是否有"十大症状"（填报前24小时内）'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '发热、干咳、乏力、鼻塞、流涕、咽痛、嗅觉/味觉减退、结膜炎、肌痛、腹泻等（简称"十大症状"）',
                                  style: BaseStyle.graySmallStyle,
                                ),
                              ),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isSymptom10.value, 9)),
                              Divider(),
                              SizedBox(
                                height: 10.h,
                              ),
                              title('本人苏康码颜色'),
                              Obx(() => radioTag('green', ['绿色', '黄色', '红色'],
                                  controller.healthCodeColor.value, 10)),
                              SizedBox(
                                height: 20.0,
                              ),
                              title('同住人员人数'),
                              Obx(() => radioTag(
                                  'green',
                                  ['0', '1', '2', '3', '4', '5', '5人以上'],
                                  controller.numberOfCohabitants.value,
                                  11)),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('本人及同住人员是否有集中隔离情况'),
                              Obx(() => radioTag('green', ['是', '否'],
                                  controller.isQuarantine.value, 12)),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                ' 其他情况说明',
                                style: textBoldStyle,
                              ),
                              Text(
                                ' 如有需要说明情况，请在此处填写',
                                style: BaseStyle.graySmallStyle,
                              ),
                              FormBuilderTextField(
                                // key: controller.formTeacherKey,
                                name: 'supplementaryNotes',
                                decoration: InputDecoration(
                                  labelText: '请填写其他需要说明的情况',
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Color(0xFFC0C0C0), width: .5),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color(0xFFA5A5A5),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                // validator: FormBuilderValidators.compose([
                                //   FormBuilderValidators.required(
                                //       errorText: '请填写内容'),
                                // ]),
                                onChanged: (e) {
                                  controller.supplementaryNotes.value = e!;
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('填报时间'),
                              SizedBox(
                                height: 10.h,
                              ),
                              formBorder(controller.getTime(), false),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('当天提交唯一标识'),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '一天提交一次',
                                  style: BaseStyle.graySmallStyle,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '提交重复表示已提交过',
                                  style: BaseStyle.graySmallStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              formBorder(
                                  '${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}-${user?.sno}',
                                  false),
                              SizedBox(
                                height: 20.h,
                              ),
                              title('信息正常/异常?'),
                              SizedBox(
                                height: 10.h,
                              ),
                              formBorder('正常', false),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.r),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: controller.isSave.value,
                          activeColor: SchoolConfig.primarySwatchColor,
                          //选中时的颜色
                          onChanged: (value) {
                            controller.isSave.value = value!;
                          },
                        ),
                        Text('保存本次提交内容，下次自动填充'),
                      ],
                    ),
                  ),
                  Divider(),
                  SchoolPushButton(
                    title: '提交',
                    onTap: () {
                      if (user?.roleList![0] == 'student') {
                        controller.formKey.currentState?.save();
                        if (controller.formKey.currentState?.validate() ==
                                false ||
                            controller.locationName.value == '') {
                          EasyLoading.showToast('您还有必填项未填');
                        } else {
                          controller.pushStudentContent();
                        }
                      } else {
                        controller.formTeacherKey.currentState?.save();
                        if (controller.formTeacherKey.currentState
                                    ?.validate() ==
                                false ||
                            controller.locationName.value == '') {
                          EasyLoading.showToast('您还有必填项未填');
                        } else {
                          controller.pushContent();
                        }
                      }
                      // if (controller.formTeacherKey.currentState?.validate() !=
                      //     null) {
                      // print(controller.formKey.currentState?.value);
                      // }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget title(String title) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '*',
            style: TextStyle(
                color: SchoolConfig.primarySwatchColor.shade500,
                fontSize: 16.sp),
          ),
          TextSpan(text: title, style: textBoldStyle),
        ],
      ),
    );
  }

  Widget tagCircle(String? avatar, String? name) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.fromLTRB(0, 0, 10.w, 0),
      decoration: BoxDecoration(
        color: SchoolConfig.primarySwatchColor.shade100,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: SchoolConfig.primarySwatchColor.shade400.withOpacity(0.3),
            width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundImage: NetworkImage(avatar!),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            name!,
            style: textStyle,
          )
        ],
      ),
    );
  }

  Widget formBorder(String? title, bool disable, {bool showSelect = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: disable
            ? SchoolConfig.primarySwatchColor.shade100
            : SchoolConfig.primarySwatchColor.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color: SchoolConfig.primarySwatchColor.shade400.withOpacity(0.3),
            width: 0.6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: textStyle,
          ),
          showSelect
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                )
              : Container()
        ],
      ),
    );
  }

  Widget radioTag(String color, List content, String groupValue, int flag) {
    return
        // Row(
        // children: [
        FormBuilderRadioGroup(
      name: 'flag$flag',
      validator: FormBuilderValidators.required(
        errorText: "此项必选",
      ),
      initialValue: groupValue,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      options: content
          .map((lang) => FormBuilderFieldOption(
                value: lang,
                child: tagColor(lang),
              ))
          .toList(growable: false),
      onChanged: (e) {
        print(e);
        switch (flag) {
          case 0:
            controller.isLocation.value = e!;
            break;
          case 1:
            controller.isInSchool.value = e!;
            break;
          case 2:
            controller.isInApartment.value = e!;
            break;
          case 3:
            controller.isStayHignrisk.value = e!;
            break;
          case 4:
            controller.isTransitHignrisk.value = e!;
            break;
          case 5:
            controller.isContactHighriskPersonnel.value = e!;
            break;
          case 6:
            controller.isGoAbroad.value = e!;
            break;
          case 7:
            controller.isContactOverseasPersonnel.value = e!;
            break;
          case 8:
            controller.isNormalTemperature.value = e!;
            break;
          case 9:
            controller.isSymptom10.value = e!;
            break;
          case 10:
            controller.healthCodeColor.value = e!;
            break;
          case 11:
            controller.numberOfCohabitants.value = e!;
            break;
          case 12:
            controller.isQuarantine.value = e!;
            break;
          case 13:
            controller.isTest48.value = e!;
            break;
          case 14:
            controller.isAccinated.value = e!;
            break;
          case 15:
            controller.isSuspectedCovid19.value = e!;
            break;
          case 16:
            controller.isAsymptomaticInfection.value = e!;
            break;
          case 17:
            controller.isContactSickPeople.value = e!;
            break;
          case 18:
            controller.isInformedByTeacher.value = e!;
            break;
          case 19:
            controller.isResponsibleForAuthenticity.value = e!;
            break;
          case 20:
            controller.isConfirmedCovid19.value = e!;
            break;
        }
      },
    );
  }

  Widget tagColor(String content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: content == '是' ||
                content == '是,已完成' ||
                content == '是,已联系告知' ||
                content == '正常' ||
                content == '绿色'
            ? Colors.green
            : content == '否' ||
                    content == '否,未接种' ||
                    content == '否,未联系告知' ||
                    content == '不正常' ||
                    content == '红色'
                ? Colors.red
                : Colors.yellow,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        content,
        style: TextStyle(
            color: content != '是' &&
                    content != '否' &&
                    content != '是,已完成' &&
                    content != '否,未接种' &&
                    content != '是,已接种' &&
                    content != '是,已联系告知' &&
                    content != '否,未联系告知' &&
                    content != '绿色' &&
                    content != '红色' &&
                    content != '正常' &&
                    content != '不正常'
                ? SchoolConfig.primarySwatchColor.shade400
                : Colors.white,
            fontSize: 14.sp),
      ),
    );
  }

// Widget inputBorder(String hint, TextEditingController textEditingController) {
//   return
//     // TextField(
//     // keyboardAppearance: Brightness.light,
//     // controller: textEditingController,
//     // style: TextStyle(
//     //     fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
//     // decoration: InputDecoration(
//     //   contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
//     //   border: OutlineInputBorder(
//     //     borderRadius: const BorderRadius.all(Radius.circular(5)),
//     //     borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
//     //   ),
//     //   focusedBorder: OutlineInputBorder(
//     //     borderRadius: const BorderRadius.all(Radius.circular(5)),
//     //     borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
//     //   ),
//     //   disabledBorder: OutlineInputBorder(
//     //     borderRadius: const BorderRadius.all(Radius.circular(5)),
//     //     borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
//     //   ),
//     //   enabledBorder: OutlineInputBorder(
//     //     borderRadius: const BorderRadius.all(Radius.circular(5)),
//     //     borderSide: BorderSide(color: Color(0xFFC0C0C0), width: .5),
//     //   ),
//     //   hintText: hint,
//     //   labelStyle: TextStyle(
//     //       color: Color(0xFFA5A5A5),
//     //       fontSize: 14.sp,
//     //       fontWeight: FontWeight.w400),
//     //   hintStyle:
//     //       const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
//     // ),
//     // keyboardType: TextInputType.multiline,
//   );
// }
}
