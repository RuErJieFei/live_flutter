import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/modules/contacts/model/type_model.dart';

import '../../../data/base_style.dart';
import '../widget/message_row_box.dart';
import '../controllers/contacts_controller.dart';
import '../widget/search_box.dart';

class ContactsView extends GetView<ContactsController> {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('南京工业职业技术大学'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: BaseData.kBackColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
            MessageRowBox(imgUrl: "images/contacts/icon_chat.png", title: "群聊"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: Text(
                "我的客户",
                style: BaseStyle.grayContentStyle,
              ),
            ),
            MessageRowBox(
                imgUrl: "images/contacts/icon_my_client.png", title: "我的客户"),
            MessageRowBox(
                imgUrl: "images/contacts/icon_add_person.png", title: "添加客户"),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: Text(
                "AI南工",
                style: BaseStyle.grayContentStyle,
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: controller.list.length,
                    itemBuilder: (BuildContext content, int index) {
                      TypeModel type = controller.list[index];
                      return MessageRowBox(
                        imgUrl: "images/contacts/icon_box.png",
                        title: type.title,
                      );
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
