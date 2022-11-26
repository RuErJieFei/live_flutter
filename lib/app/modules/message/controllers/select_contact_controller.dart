import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';

class SelectContactController extends GetxController {
  final groupMembers = <String>{}.obs; // 新建群聊的人员id
  // todo: 添加集合里或移除
  void addOrRemove(bool isSelected, String id) {
    if (isSelected) {
      groupMembers.remove(id);
    } else {
      groupMembers.add(id);
    }
  }

  // todo: 创建群聊会话
  void createGroupConversation(String GroupName) async {
    var msgCto = Get.find<MessageController>();
    try {
      await msgCto.me.createConversation(isUnique: true, members: groupMembers, name: GroupName);
      // 返回到首页
      msgCto.updateConversationList();
      // Get.offNamed('/index');
      Get.back();
      Get.back();
    } catch (e) {
      EasyLoading.showError('创建会话失败:');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
