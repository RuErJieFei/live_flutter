import 'dart:convert';
/// id : 30
/// roomId : "1049360418415312896"
/// roomName : "花日"
/// cover : "http://124.221.232.15:9090/hlh/下载.jpeg"
/// roomKey : "L17LTlsVqMNTZyLKMIFSD2x28MlgPJ0SDZVHnHJPxMKi0tWx"
/// protocol : "rtmp"
/// ownerId : "6373407d425453a1234321e0"
/// ownerName : "杨阳"
/// ownerAvatar : "https://files.authing.co/user-contents/photos/e78e6017-2bcc-4c83-9e19-980f6fb16fa2.jpg"
/// open : "是"
/// beauty : 14
/// location : "江苏南京"
/// type : "语文课"
/// limitNumber : "10"
/// comment : "是"
/// status : "开"
/// revision : null
/// createdBy : null
/// createdTime : "2022-12-05 16:23:40"
/// updatedBy : null
/// updatedTime : "2022-12-05 16:23:40"

Room roomFromJson(String str) => Room.fromJson(json.decode(str));
String roomToJson(Room data) => json.encode(data.toJson());
class Room {
  Room({
      num? id, 
      String? roomId, 
      String? roomName, 
      String? cover, 
      String? roomKey, 
      String? protocol, 
      String? ownerId, 
      String? ownerName, 
      String? ownerAvatar, 
      String? open, 
      num? beauty, 
      String? location, 
      String? type, 
      String? limitNumber, 
      String? comment, 
      String? status, 
      dynamic revision, 
      dynamic createdBy, 
      String? createdTime, 
      dynamic updatedBy, 
      String? updatedTime,}){
    _id = id;
    _roomId = roomId;
    _roomName = roomName;
    _cover = cover;
    _roomKey = roomKey;
    _protocol = protocol;
    _ownerId = ownerId;
    _ownerName = ownerName;
    _ownerAvatar = ownerAvatar;
    _open = open;
    _beauty = beauty;
    _location = location;
    _type = type;
    _limitNumber = limitNumber;
    _comment = comment;
    _status = status;
    _revision = revision;
    _createdBy = createdBy;
    _createdTime = createdTime;
    _updatedBy = updatedBy;
    _updatedTime = updatedTime;
}

  Room.fromJson(dynamic json) {
    _id = json['id'];
    _roomId = json['roomId'];
    _roomName = json['roomName'];
    _cover = json['cover'];
    _roomKey = json['roomKey'];
    _protocol = json['protocol'];
    _ownerId = json['ownerId'];
    _ownerName = json['ownerName'];
    _ownerAvatar = json['ownerAvatar'];
    _open = json['open'];
    _beauty = json['beauty'];
    _location = json['location'];
    _type = json['type'];
    _limitNumber = json['limitNumber'];
    _comment = json['comment'];
    _status = json['status'];
    _revision = json['revision'];
    _createdBy = json['createdBy'];
    _createdTime = json['createdTime'];
    _updatedBy = json['updatedBy'];
    _updatedTime = json['updatedTime'];
  }
  num? _id;
  String? _roomId;
  String? _roomName;
  String? _cover;
  String? _roomKey;
  String? _protocol;
  String? _ownerId;
  String? _ownerName;
  String? _ownerAvatar;
  String? _open;
  num? _beauty;
  String? _location;
  String? _type;
  String? _limitNumber;
  String? _comment;
  String? _status;
  dynamic _revision;
  dynamic _createdBy;
  String? _createdTime;
  dynamic _updatedBy;
  String? _updatedTime;

  num? get id => _id;
  String? get roomId => _roomId;
  String? get roomName => _roomName;
  String? get cover => _cover;
  String? get roomKey => _roomKey;
  String? get protocol => _protocol;
  String? get ownerId => _ownerId;
  String? get ownerName => _ownerName;
  String? get ownerAvatar => _ownerAvatar;
  String? get open => _open;
  num? get beauty => _beauty;
  String? get location => _location;
  String? get type => _type;
  String? get limitNumber => _limitNumber;
  String? get comment => _comment;
  String? get status => _status;
  dynamic get revision => _revision;
  dynamic get createdBy => _createdBy;
  String? get createdTime => _createdTime;
  dynamic get updatedBy => _updatedBy;
  String? get updatedTime => _updatedTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['roomId'] = _roomId;
    map['roomName'] = _roomName;
    map['cover'] = _cover;
    map['roomKey'] = _roomKey;
    map['protocol'] = _protocol;
    map['ownerId'] = _ownerId;
    map['ownerName'] = _ownerName;
    map['ownerAvatar'] = _ownerAvatar;
    map['open'] = _open;
    map['beauty'] = _beauty;
    map['location'] = _location;
    map['type'] = _type;
    map['limitNumber'] = _limitNumber;
    map['comment'] = _comment;
    map['status'] = _status;
    map['revision'] = _revision;
    map['createdBy'] = _createdBy;
    map['createdTime'] = _createdTime;
    map['updatedBy'] = _updatedBy;
    map['updatedTime'] = _updatedTime;
    return map;
  }

}