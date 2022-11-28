import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import 'package:wit_niit/app/modules/message/bindings/message_binding.dart';
import 'package:wit_niit/app/modules/message/controllers/chat_controller.dart';
import 'package:wit_niit/app/modules/message/controllers/message_controller.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/views/select_contact_view.dart';

class ConversationInfoView extends GetView<ChatController> {
  const ConversationInfoView(this.conversation, {Key? key}) : super(key: key);
  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    int membersCount = conversation.members?.length as int;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: membersCount > 2 ? Text('聊天信息($membersCount)') : Text('聊天信息'),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: Config.mainColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListView(
              children: [
                /// 群成员
                _groupMembers(),

                /// 查找记录
                _findHistory(),

                /// 群信息
                Offstage(
                  offstage: membersCount > 2 ? false : true,
                  child: _groupInfo(),
                ),

                /// 设置
                _operateBar(),

                /// 其他
                Offstage(
                  offstage: membersCount > 2 ? false : true,
                  child: _othersWidget(),
                ),

                /// 退出群聊
                Offstage(
                  offstage: membersCount > 2 ? false : true,
                  child: _exitWidget(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 查找聊天记录
  Widget _findHistory() {
    return Card(
      child: ListTile(
        onTap: () {
          EasyLoading.showToast('开发中～');
        },
        title: Text('查找聊天记录'),
        trailing: Wrap(
          children: [
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }

  /// 群成员
  Widget _groupMembers() {
    var msgCto = Get.find<MessageController>();
    int membersCount = conversation.members?.length as int;
    List? membersList = conversation.members;
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.all(10.w),
        height: membersCount < 19 ? 93.w * (membersCount / 5).ceil() : 369.w,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            childAspectRatio: 0.8,
          ),
          itemCount: membersCount + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 55.w,
                      width: 55.w,
                      child: Icon(Icons.add, color: Colors.grey),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () async {
                      // 邀请入群
                      Set<String> members = await Get.to(
                        () => SelectContactView(type: 2),
                        binding: MessageBinding(),
                      );
                      if (members.length != 0) {
                        controller.addMembers(conversation.id, members);
                        Get.back();
                      }
                    },
                  ),
                ],
              );
            }
            ContactModel? member = msgCto.contactsMap[membersList![index - 1]];
            return Column(
              children: [
                Expanded(
                  child: InkWell(
                    onLongPress: () {
                      // 群创建者可以将他人移出群聊
                      if (conversation.creator == msgCto.me.id) {
                        Get.dialog(CupertinoAlertDialog(
                          title: Text('将 ${member?.name} 移出群聊？'),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('确定'),
                              onPressed: () {
                                controller.removeMember(conversation, '${member?.id}');
                                Get.back();
                                Get.back();
                              },
                            ),
                          ],
                        ));
                      }
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network('${member?.photo}'),
                    ),
                  ),
                ),
                Text('${member?.name}'),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 群信息
  Widget _groupInfo() {
    ContactModel? creator = Get.find<MessageController>().contactsMap[conversation.creator];
    return Card(
      margin: EdgeInsets.only(top: 10),
      elevation: 1,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('群聊名称'),
            trailing: Wrap(
              children: [
                Text('${conversation.name}'),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          ListTile(
            title: Text('管理员'),
            trailing: Text('${creator?.name}'),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('群二维码'),
            trailing: Wrap(
              children: [
                Icon(Icons.qr_code),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('群公告'),
            trailing: Wrap(
              children: [
                Text('未设置'),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('备注'),
            trailing: Wrap(
              children: [
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 操作栏
  Widget _operateBar() {
    var DND = false.obs;
    var ViewTop = false.obs;
    var Save = false.obs;
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          ListTile(
            title: Text('消息免打扰'),
            trailing: Obx(() {
              return CupertinoSwitch(
                activeColor: Config.viceColor,
                value: DND.value,
                onChanged: (bool value) {
                  // DND.value = value;
                },
              );
            }),
          ),
          ListTile(
            title: Text('置顶聊天'),
            trailing: Obx(() {
              return CupertinoSwitch(
                activeColor: Config.viceColor,
                value: ViewTop.value,
                onChanged: (bool value) {
                  // ViewTop.value = value;
                },
              );
            }),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('保存到通讯录'),
            trailing: Obx(() {
              return CupertinoSwitch(
                activeColor: Config.viceColor,
                value: Save.value,
                onChanged: (bool value) {
                  // Save.value = value;
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 其他
  Widget _othersWidget() {
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('查看群成员日程'),
            trailing: Wrap(
              children: [
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('邀请群成员语音通话'),
            trailing: Wrap(
              children: [
                Icon(Icons.arrow_right),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              EasyLoading.showToast('开发中～');
            },
            title: Text('给群成员发邮件'),
            trailing: Wrap(
              children: [
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 退出群聊
  Widget _exitWidget() {
    TextStyle ts = TextStyle(color: Colors.red, fontSize: 20.sp);
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // TextButton(
            //   onPressed: () {
            //     EasyLoading.showToast('不许清空');
            //   },
            //   child: Text('清空聊天记录', style: ts),
            // ),
            // Divider(indent: 6, endIndent: 6),
            TextButton(
              onPressed: () {
                EasyLoading.showToast('不许润');
              },
              child: Text('退出群聊', style: ts),
            ),
          ],
        ),
      ),
    );
  }
}
