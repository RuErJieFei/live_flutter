import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_data.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/contacts/bindings/dept_binding.dart';
import 'package:wit_niit/app/modules/contacts/controllers/contacts_controller.dart';
import 'package:wit_niit/app/modules/contacts/model/dept_data.dart';
import 'package:wit_niit/app/modules/contacts/model/type_model.dart';
import 'package:wit_niit/app/modules/contacts/views/dept_view.dart';
import 'package:wit_niit/app/modules/contacts/widget/message_row_box.dart';
import 'package:wit_niit/app/modules/contacts/widget/search_box.dart';

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
            MessageRowBox(
              imgUrl: "images/contacts/icon_chat.png",
              title: "群聊",
              isUser: false,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 18.0),
              child: Text(
                "我的客户",
                style: BaseStyle.grayContentStyle,
              ),
            ),
            MessageRowBox(
              imgUrl: "images/contacts/icon_my_client.png",
              title: "我的客户",
              isUser: false,
            ),
            MessageRowBox(
              imgUrl: "images/contacts/icon_add_person.png",
              title: "添加客户",
              isUser: false,
            ),
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
                      DeptData data = DeptData(typeId: type.pkId, deptId: 0);
                      return InkWell(
                        onTap: () => Get.to(() => DeptView(title: type.title),
                            binding: DeptBinding(), arguments: data),
                        child: MessageRowBox(
                          imgUrl: "images/contacts/icon_box.png",
                          title: type.title,
                          isUser: false,
                        ),
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
