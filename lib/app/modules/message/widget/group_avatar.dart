// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';

/// 创建时间：2022/11/29
/// 作者：w2gd
/// 描述：群头像

class GroupAvatar extends GetView<MessageController> {
  const GroupAvatar({Key? key, required this.list}) : super(key: key);
  final List? list;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list!.length >= 9 ? 9 : 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: list!.length < 9 ? 2 : 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        ContactModel? contact = controller.contactsMap[list?[index]];
        return Image.network('${contact?.photo}');
      },
    );
  }
}
