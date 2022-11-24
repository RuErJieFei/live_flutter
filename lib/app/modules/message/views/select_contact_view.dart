import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/component/bg_position_image.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/select_contact_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';

class SelectContactView extends GetView<MessageController> {
  const SelectContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('选择联系人'),
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
          itemCount: controller.contactList.length,
          itemBuilder: (BuildContext context, int index) {
            return _contactTile(
              contactor: controller.contactList[index],
            );
          },
        ),
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
          leading: BGPositionImage.positionImage('${contactor.photo}'),
          title: Text('${contactor.name}'),
          trailing: Offstage(
            offstage: !isSelected.value,
            child: Icon(Icons.check),
          ),
          selectedColor: Colors.pink,
          selected: isSelected.value,
          selectedTileColor: Config.viceColor,
          onTap: () {
            isSelected.value = !isSelected.value;
            // 加入群聊数组或删除
          },
        );
      }),
    );
  }
}
