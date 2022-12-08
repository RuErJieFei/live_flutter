import 'dart:convert';
/// avatar : "https://files.authing.co/user-contents/photos/e78e6017-2bcc-4c83-9e19-980f6fb16fa2.jpg"
/// msg : {"content":"123","fromId":"6373407d425453a1234321e0","roomId":"1050119112342110208","type":2}
/// username : "杨阳"

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());
class Message {
  Message({
      String? avatar, 
      Msg? msg, 
      String? username,}){
    _avatar = avatar;
    _msg = msg;
    _username = username;
}

  Message.fromJson(dynamic json) {
    _avatar = json['avatar'];
    _msg = json['msg'] != null ? Msg.fromJson(json['msg']) : null;
    _username = json['username'];
  }
  String? _avatar;
  Msg? _msg;
  String? _username;

  String? get avatar => _avatar;
  Msg? get msg => _msg;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = _avatar;
    if (_msg != null) {
      map['msg'] = _msg?.toJson();
    }
    map['username'] = _username;
    return map;
  }

}

/// content : "123"
/// fromId : "6373407d425453a1234321e0"
/// roomId : "1050119112342110208"
/// type : 2

Msg msgFromJson(String str) => Msg.fromJson(json.decode(str));
String msgToJson(Msg data) => json.encode(data.toJson());
class Msg {
  Msg({
      String? content, 
      String? fromId, 
      String? roomId, 
      num? type,}){
    _content = content;
    _fromId = fromId;
    _roomId = roomId;
    _type = type;
}

  Msg.fromJson(dynamic json) {
    _content = json['content'];
    _fromId = json['fromId'];
    _roomId = json['roomId'];
    _type = json['type'];
  }
  String? _content;
  String? _fromId;
  String? _roomId;
  num? _type;

  String? get content => _content;
  String? get fromId => _fromId;
  String? get roomId => _roomId;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = _content;
    map['fromId'] = _fromId;
    map['roomId'] = _roomId;
    map['type'] = _type;
    return map;
  }

}