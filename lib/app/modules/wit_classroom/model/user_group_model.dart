class UserGroupModel {
  int? id;
  String? groupName;
  String? userId;
  String? createTime;
  String? updateTime;

  UserGroupModel(
      {this.id, this.groupName, this.userId, this.createTime, this.updateTime});

  UserGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['groupName'];
    userId = json['userId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupName'] = this.groupName;
    data['userId'] = this.userId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
