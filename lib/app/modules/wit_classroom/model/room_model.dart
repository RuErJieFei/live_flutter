class RoomModel {
  int? id;
  String? roomName;
  int? groupId;
  String? createTime;
  String? updateTime;

  RoomModel(
      {this.id, this.roomName, this.groupId, this.createTime, this.updateTime});

  RoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['roomName'];
    groupId = json['groupId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomName'] = this.roomName;
    data['groupId'] = this.groupId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
