import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:leancloud_official_plugin/leancloud_plugin.dart';
import 'package:wit_niit/app/modules/login/model/user_model.dart';
import 'package:wit_niit/app/modules/message/model/contact_model.dart';
import 'package:wit_niit/app/modules/message/widget/date_bar.dart';
import 'package:wit_niit/app/modules/message/widget/my_message_tile.dart';
import 'package:wit_niit/main.dart';

class MessageController extends GetxController {
  /// 创建一个 Client
  Client me = Client(id: '${SpUtil.getString('userId')}');

  /// 会话列表
  final conversationList = <Conversation>[].obs;

  /// 某个会话的聊天记录
  var recordList = <Widget>[].obs;

  /// 当前正在进行的会话
  late Conversation currentConv;

  /// 计数： 监听到的新消息数量
  final msgCount = 0.obs;

  /// 我的信息

  @override
  void onInit() {
    super.onInit();
    getContacts(); // 获取通讯录
  }

  @override
  void onReady() async {
    super.onReady();
    await me.open(); // 登录LeanCloud
    // 获取成功后再获取会话列表，要设置延迟 Loading
    EasyLoading.show(status: '正在获取会话');
    await updateConversationList().then((value) {
      EasyLoading.dismiss();
    });
    // 监听消息
    me.onMessage = ({
      Client? client,
      Conversation? conversation,
      Message? message,
    }) {
      LogUtil.v('收到消息------------');
      // 在首页则立即更新会话列表
      if (Get.currentRoute == '/index') {
        updateConversationList();
      } else {
        // 新消息的id 与当前增长聊天的id 不同，则出现 snackbar 提示
        if (currentConv.id == conversation?.id) {
          // LogUtil.v('id 相等${message.fromClientID}');
          // 添加到当前聊天记录列表
          var msg = getMsgWidget(message!);
          // recordList.add(msg); // 尾部加
          recordList.insert(0, msg); // 头部加
          msgCount.value++;
        } else {
          // LogUtil.v('id 不相等${message.fromClientID}');
          if (message is TextMessage) {
            Get.snackbar('新消息', '${message.text}');
          }
        }
      }
    };
    // 加入成员通知
    me.onMembersJoined = ({
      Client? client,
      Conversation? conversation,
      List? members,
      String? byClientID,
      DateTime? atDate,
    }) {
      updateConversationList();
      if (currentConv.id == conversation?.id) {
        members?.forEach((id) {
          ContactModel? contact = contactsMap[id];
          recordList.insert(0, DateBar(lable: '${contact?.name} 加入了群聊'));
        });
      }
    };
    // 有成员被从某个对话中移除
    me.onMembersLeft = ({
      Client? client,
      Conversation? conversation,
      List? members,
      String? byClientID,
      DateTime? atDate,
    }) {
      if (currentConv.id == conversation?.id) {
        members?.forEach((id) {
          ContactModel? contact = contactsMap[id];
          recordList.insert(0, DateBar(lable: '成员 ${contact?.name} 被移出群聊'));
        });
      }
    };
    // 用户被踢出某个对话
    me.onKicked = ({
      Client? client,
      Conversation? conversation,
      String? byClientID,
      DateTime? atDate,
    }) {
      if (currentConv.id == conversation?.id) {
        recordList.insert(0, DateBar(lable: '你已被移出群聊'));
      }
    };
    // 对话属性同步：比如通知修改了群名称
    me.onInfoUpdated = ({
      Client? client,
      Conversation? conversation,
      Map? updatingAttributes,
      Map? updatedAttributes,
      String? byClientID,
      DateTime? atDate,
    }) {
      updateConversationList();
      if (currentConv.id == conversation?.id) {
        recordList.insert(0, DateBar(lable: '群名被修改为：${conversation?.name}'));
      }
    };
  }

  @override
  void onClose() {
    me.close(); // 下线
    super.onClose();
  }

  // Todo: 创建私聊会话
  Future<Conversation> createConversation(String friendId, String friendName) async {
    UserModel? myInfo = SpUtil.getObj("user", (v) => UserModel.fromJson(v as Map<String, dynamic>));
    Conversation conversation = await me.createConversation(
      isUnique: true,
      members: {friendId},
      name: '${myInfo?.name} $friendName',
    );
    return conversation;
  }

  /// 联系人集合 map 类型
  RxMap<String, ContactModel> contactsMap = <String, ContactModel>{}.obs;

  // todo:获取 Authing 用户池列表
  void getContacts() async {
    Map? map = SpUtil.getObject('contactList');
    if (map != null) {
      LogUtil.v('从本地读取联系人');
      map.forEach((key, value) {
        ContactModel contact = ContactModel.fromJson(value);
        contactsMap[key] = contact;
      });
    } else {
      Map<String, dynamic> params = {"page": 1, "limit": 50};
      List res = await request.get('/users/userlist', params: params);
      res.forEach((e) {
        ContactModel contact = ContactModel.fromJson(e);
        contactsMap['${contact.id}'] = contact;
        LogUtil.v('存入一个联系人 +1');
      });
      LogUtil.v('完成所有联系人存入');
      SpUtil.putObject('contactList', contactsMap);
    }
  }

  // Todo: 获取当前用户参与过的会话列表
  // 会话名称、会话的成员，会话的最后一条消息。还需要展示未读消息数目。
  Future updateConversationList() async {
    ConversationQuery query = me.conversationQuery();
    query.orderByDescending('updatedAt'); // 按照会话的更新时间排序
    query.includeLastMessage = true; // 让查询结果附带一条最新消息
    conversationList.value = await query.find();
    return true;
  }

  // Todo: 会话里最新一条消息的文本
  String getLastMessageInfo(Message? message) {
    if (message is TextMessage) {
      return message.text ?? '';
    } else if (message is ImageMessage) {
      return '[图片]';
    } else if (message is VideoMessage) {
      return '[视频]';
    } else if (message is AudioMessage) {
      return '[语音]';
    }
    return '';
  }

  // todo: 获取会话成员
  Future<String> getMemberId(Conversation conversation) async {
    List list = conversation.members as List;
    if (list.length == 1) {
      return list[0];
    }
    if (list.length == 2) {
      for (var v in list) {
        if (v != SpUtil.getString('userId')) {
          return v;
        }
      }
    }
    return list[0];
  }

  // todo: 时间处理
  String dealDate(DateTime? dateTime) {
    String today = DateUtil.formatDate(DateTime.now(), format: DateFormats.y_mo_d);
    String msgTime = DateUtil.formatDate(dateTime, format: DateFormats.y_mo_d);
    if (today == msgTime) {
      // 今天的消息,返回 时：分
      return DateUtil.formatDate(dateTime, format: DateFormats.h_m);
    } else {
      // 返回 月：日
      return DateUtil.formatDate(dateTime, format: DateFormats.mo_d);
    }
    // 拓展： 是否是今年，返回年月日；是否是本周，返回周几；
  }

  // Todo: 返回我的消息widget
  // imageType: 0 本地， 1网络
  Widget getMyMsgWidget(Message e, {String? path, int? imageType}) {
    if (e is TextMessage) {
      return MessageOwnTile(
        messageDate: dealDate(e.sentDate),
        widget: TextMsg(message: '${e.text}'),
      );
    } else if (e is ImageMessage && imageType == 0) {
      return MessageOwnTile(
        messageDate: dealDate(e.sentDate),
        widget: ImgFileMsg(filepath: path!),
      );
    } else if (e is ImageMessage) {
      return MessageOwnTile(
        messageDate: dealDate(e.sentDate),
        widget: ImgNetMsg(imgUrl: e.url),
      );
    } else {
      return MessageOwnTile(
        messageDate: dealDate(e.sentDate),
        widget: TextMsg(message: '错误消息类型，无法显示!'),
      );
    }
  }

  // Todo: 返回别人的消息widget
  Widget getMsgWidget(Message e) {
    if (e is TextMessage) {
      return MessageTile(
        senderId: e.fromClientID,
        messageDate: dealDate(e.sentDate),
        widget: TextMsg(message: '${e.text}', type: 1),
      );
    } else if (e is ImageMessage) {
      return MessageTile(
        senderId: e.fromClientID,
        messageDate: dealDate(e.sentDate),
        widget: ImgNetMsg(imgUrl: e.url),
      );
    } else {
      return MessageTile(
        senderId: e.fromClientID,
        messageDate: dealDate(e.sentDate),
        widget: TextMsg(message: '错误消息类型，无法显示!'),
      );
    }
  }

  // todo: 用户主动加入对话
  void joinConversation(String ConvId) async {
    List<Conversation> conversations;
    try {
      ConversationQuery query = me.conversationQuery();
      query.whereEqualTo('objectId', ConvId);
      conversations = await query.find();
      Conversation conversation = conversations.first;
      MemberResult joinResult = await conversation.join();
      LogUtil.v('${joinResult}');
    } catch (e) {
      LogUtil.v(e);
    }
  }
}
