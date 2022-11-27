import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/message/widget/date_bar.dart';
import 'package:wit_niit/app/modules/notice/widget/bubble.dart';
import 'package:wit_niit/main.dart';

import '../model/notice.dart';

class NoticeController extends GetxController {
  //TODO: Implement NoticeController
  var noticeList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNoticeList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getNoticeList() async {
    var data =
        await request.get('/shisheng/notice/all');
    // 聊天记录渲染
    data.forEach((e) {
      Notice record = Notice.fromJson(e);
      // LogUtil.v(record.toJson());
      noticeList.add(
        Column(
          children: [
            DateBar(lable: record.noticeTime!),
            Bubble(
              direction: BubbleDirection.left,
              color: Colors.blueAccent,
              child: Text(
                record.message!,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )
      );
    });
  }
}
