
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:faker/faker.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:video_player/video_player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wit_niit/app/modules/bench/model/schedule_model.dart';
import '../../../../main.dart';
import '../../../config/net_url.dart';
import '../../../data/helpers.dart';
import '../model/schedule_model_release.dart';


const String VIDEO_URL = 'https://www.runoob.com/try/demo_source/mov_bbb.mp4';
class SchedulePageController extends GetxController {
  //TODO: Implement BenchController
  var id = SpUtil.getString('userId');
  // var channel;
// channel = IOWebSocketChannel.connect(Uri.parse('${NetUrl.socket_HostName}$id'));
//   addConnection(){
//     channel = WebSocketChannel.connect(
//         Uri.parse('${NetUrl.socket_HostName}$id')
//     );
//   }
  var  videoContro = VideoPlayerController.network(VIDEO_URL).obs;
  late Future initializeVideoPlayerFuture;

  var  dura = 0.0.obs; //视频播放比

  var attachmentList = [].obs;
  final count = 0.obs;
  final unClickColor = Colors.black.obs;
  /// 日程新增页面的开始时间
  var selectedStartDay = DateTime
      .now()
      .obs;
  /// 日程新增页面的结束时间
  var selectedEndDay = DateTime
      .now()
      .obs;
  var isAllDay = false.obs;
  /// 日程列表
  var scheduleList = [].obs;
  /// 用户列表
  var userList = [].obs;
  /// 新增主题控制器
  var topicController = TextEditingController().obs;
  /// 新增地址
  var addressController = TextEditingController().obs;
  /// 新增描述
  var descriptionController = TextEditingController().obs;
  /// 日程选择器选择日期
  var selectedDay = DateTime.now().obs;
  /// 日程编辑页面的开始时间
  var selectedEditStartDay = DateTime
      .now()
      .obs;
  /// 日程编辑页面的结束时间
  var selectedEditEndDay = DateTime
      .now()
      .obs;
  var isAllDayEdit = false.obs;
  /// 编辑主题控制器
  var topicEditController = TextEditingController().obs;
  /// 编辑地址
  var addressEditController = TextEditingController().obs;
  /// 编辑描述
  var descriptionEditController = TextEditingController().obs;

  // final ImagePicker picker = ImagePicker();

  /// 添加一条记录到日程列表
  void addSchedule() {
    final Faker faker = Faker(); // 假数据
    final date = Helpers.randomDate();
    ScheduleData data = ScheduleData(
      topic: faker.job.title(),
      address: faker.address.city(),
      time: Jiffy(date).format("HH:ss"),
      organizerName: faker.person.name(),
        durationTime: faker.date.dateTime().minute,
      description: faker.food.dish()
    );
    scheduleList.add(data);
  }
  Future<List> getScheduleByDate() async {
    String? userId = SpUtil.getString("userId");
    print(userId);
    var day = formatDate(selectedDay.value, [
      yyyy,
      "/",
      mm,
      "/",
      dd,
    ]);
    print(day);
    Map<String, dynamic> params = {"date": day, "organizationId": userId};
    // var res = await Dio().get("http://121.40.208.79:10000/api/schedule/searchScheduleByUserIdAndDate",queryParameters: params);
    var res = await request.get(
        "/schedule/searchScheduleByUserIdAndDate",
        params: params);
    print(res);
    // var result = ScheduleModel.fromJson(json.decode(res.toString()));
    // print(result.data);
    return res;
  }
  @override
  void onInit() async{
    super.onInit();
    scheduleList.value =await getScheduleByDate();
    scheduleList.value = scheduleList.map((element) => Data.fromJson(element)).toList();
   // addConnection();
    // for (int i = 1; i <= 8; i++) {
    //   addSchedule();
    // }

    // videoContro = VideoPlayerController.file(new File(attachmentList[0].path));
    // videoContro.setLooping(true);
    var now = DateTime.now();
    selectedStartDay.value = DateTime.now();
    selectedEndDay.value =
    new DateTime(now.year, now.month, now.day, now.hour + 1, now.minute);
    initializeVideoPlayerFuture = videoContro.value.initialize();

  }

  @override
  void onReady() {
    super.onReady();

    }

  @override
  void onClose() {
    super.onClose();
    selectedDay.value = DateTime.now();
    // channel.sink.close();
    videoContro.value.dispose();
  }

  void increment() => count.value++;
}
