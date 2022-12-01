class DeviceTypeModel {
  int? id;
  String? typeName;
  String? createTime;
  String? updateTime;

  DeviceTypeModel({this.id, this.typeName, this.createTime, this.updateTime});

  DeviceTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['typeName'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeName'] = this.typeName;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
