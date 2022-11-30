// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/component/image_show_server.dart';

/// 创建时间：2022/11/30
/// 作者：w2gd
/// 描述：消息记录里的图片

class HistoryImages extends StatefulWidget {
  const HistoryImages({Key? key, required this.conv}) : super(key: key);
  final Conversation conv;

  @override
  State<HistoryImages> createState() => _HistoryImagesState();
}

class _HistoryImagesState extends State<HistoryImages> {
  List images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片'),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // 查看大图
                  List _showList = images;
                  Get.to(
                    () => ImageShowServer(
                      type: 1,
                      photoList: _showList,
                      initialIndex: index,
                    ),
                  );
                },
                child: BGPositionImage.positionImage('${images[index]}'),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.conv.queryMessage(type: -2, limit: 100).then((data) {
      images = data.map((e) {
        if (e is ImageMessage) {
          return e.url;
        }
      }).toList();
      setState(() {});
    });
  }
}
