import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/live_class/views/live_view.dart';
import 'package:wit_niit/app/modules/live_class/views/live_watching.dart';

import '../controllers/live_class_controller.dart';

class LiveClassView extends GetView<LiveClassController> {
  const LiveClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('上课直播'),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 200,
              child: CupertinoButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LiveView()));
                  },
                  child: Text('开启直播')),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 200,
              child: CupertinoButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LiveWatching()));
                  },
                  child: Text('观看直播')),
            )
          ],
        ),
      ),
    );
  }
}
