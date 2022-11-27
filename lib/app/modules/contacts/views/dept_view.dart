import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wit_niit/app/modules/contacts/controllers/dept_controller.dart';
import 'package:wit_niit/app/modules/contacts/model/dept_data.dart';
import 'package:wit_niit/app/modules/contacts/model/dept_model.dart';
import 'package:wit_niit/app/modules/contacts/views/user_info_view.dart';
import 'package:wit_niit/app/modules/contacts/widget/message_row_box.dart';
import 'package:wit_niit/app/modules/contacts/widget/search_box.dart';

import '../bindings/user_info_binding.dart';

class DeptView extends GetView<DeptController> {
  DeptView({required this.title, Key? key}) : super(key: key);
  late final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SearchWidget(),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    DeptModel dept = controller.list[index];
                    DeptData data = DeptData(
                        typeId: controller.deptData.typeId, deptId: dept.pkId);
                    return InkWell(
                        onTap: () => {
                              if (dept.userId.isEmpty)
                                {
                                  controller.deptData = data,
                                  controller.getDeptList(),
                                }
                              else
                                {
                                  Get.to(() => UserInfoView(),
                                      binding: UserInfoBinding(),
                                      arguments: dept.userId)
                                }
                            },
                        child: MessageRowBox(
                          imgUrl: dept.photo.isEmpty
                              ? "images/contacts/icon_box.png"
                              : dept.photo,
                          title: dept.photo.isEmpty
                              ? dept.pkId.toString() + ". " + dept.title
                              : dept.name,
                          isUser: !dept.userId.isEmpty,
                        ));
                  },
                  itemCount: controller.list.length,
                );
              }),
            ),
          ],
        ));
  }
}
