/// 创建时间：2022/11/21
/// 作者：w2gd
/// 描述：私聊记录模型

class PrivateChatRecord {
  PrivateChatRecord({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.content,
    required this.type,
    required this.createTime,
  });
  late final int id;
  late final String fromId;
  late final String toId;
  late final String content;
  late final int type;
  late final String createTime;

  PrivateChatRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['fromId'];
    toId = json['toId'];
    content = json['content'];
    type = json['type'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fromId'] = fromId;
    _data['toId'] = toId;
    _data['content'] = content;
    _data['type'] = type;
    _data['createTime'] = createTime;
    return _data;
  }
}
