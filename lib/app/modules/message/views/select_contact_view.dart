import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/select_contact_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';

class SelectContactView extends StatelessWidget {
  const SelectContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msgCto = Get.find<MessageController>();
    final scCto = Get.find<SelectContactController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() {
          return Text('选择联系人 ${scCto.groupMembers.length}');
        }),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.close, size: 30),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined, size: 30),
            onPressed: () {
              EasyLoading.showToast('暂不支持搜索，开发中～');
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: msgCto.contactsMap.length,
          itemBuilder: (BuildContext context, int index) {
            return _contactTile(
              contactor: msgCto.contactsMap.values.elementAt(index),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        return Offstage(
          offstage: scCto.groupMembers.isEmpty,
          child: FloatingActionButton(
            backgroundColor: Config.mainColor,
            onPressed: () {
              showDialog(context: context, builder: (_) => _customDialog());
            },
            child: Icon(Icons.group_add),
          ),
        );
      }),
    );
  }

  // 弹窗、输入群聊名称
  Widget _customDialog() {
    TextEditingController textTf = TextEditingController();
    return CupertinoAlertDialog(
      title: Text('输入群聊名称'),
      actions: [
        CupertinoDialogAction(child: Text('取消'), onPressed: () => Get.back()),
        CupertinoDialogAction(
          child: Text('创建'),
          onPressed: () {
            if (textTf.text.trim().isEmpty) {
              EasyLoading.showToast('群名称不能为空');
              return;
            }
            Get.find<SelectContactController>().createGroupConversation(textTf.text);
          },
        ),
      ],
      content: Column(
        children: [CupertinoTextField(controller: textTf)],
      ),
    );
  }
}

class _contactTile extends GetView<SelectContactController> {
  const _contactTile({Key? key, required this.contactor}) : super(key: key);
  final ContactModel contactor;

  @override
  Widget build(BuildContext context) {
    var isSelected = false.obs;
    return Container(
      height: 60.h,
      child: Obx(() {
        return ListTile(
          leading: Container(
            height: 55.r,
            width: 55.r,
            child: BGPositionImage.positionImage('${contactor.photo}'),
          ),
          title: Text('${contactor.name}'),
          trailing: Offstage(
            offstage: !isSelected.value,
            child: Icon(Icons.check),
          ),
          selectedColor: Colors.pink,
          selected: isSelected.value,
          selectedTileColor: Config.viceColor,
          onTap: () {
            controller.addOrRemove(isSelected.value, '${contactor.id}');
            isSelected.value = !isSelected.value;
            // 加入群聊数组或删除
          },
        );
      }),
    );
  }
}
