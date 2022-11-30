class DeviceModel {
  int? id;
  int? deviceNum;
  String? deviceName;
  String? topic;
  int? deviceStatus;
  String? createTime;

  DeviceModel(
      {this.id,
      this.deviceNum,
      this.deviceName,
      this.topic,
      this.deviceStatus,
      this.createTime});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceNum = json['deviceNum'];
    deviceName = json['deviceName'];
    topic = json['topic'];
    deviceStatus = json['deviceStatus'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceNum'] = this.deviceNum;
    data['deviceName'] = this.deviceName;
    data['topic'] = this.topic;
    data['deviceStatus'] = this.deviceStatus;
    data['createTime'] = this.createTime;
    return data;
  }
}
