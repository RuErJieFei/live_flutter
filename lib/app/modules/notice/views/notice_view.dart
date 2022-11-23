import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/message/widget/date_bar.dart';
import '../controllers/notice_controller.dart';
import '../widget/bubble.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知公告'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0.w),
        reverse: true,
        itemCount: 5,
        itemBuilder: (_, int index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DateBar(lable: "111111111111"),
            Bubble(
              direction: BubbleDirection.left,
              color: Colors.blueAccent,
              child: Text(
                "各位同学大家好，我校2023届毕业生秋季线上综合招聘会将于10月29日（明天）上午9：00-12：00线上举行，详情请访问”南工就创业微信公众号“，点击就业指导—29日云招聘。本次活动已于10月28日下午16：00预热投递简历，29日上午将正式举行，请同学们提前准备好电子简历，登录云招聘平台，查询企业信息，记录好意向企业腾讯会议号及交流群，明天上午踊跃投递简历，积极参加线上面试。",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
