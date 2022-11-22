class ScheduleModel {
  ScheduleModel({
    required this.data,
  });
  late final List<Data> data;

  ScheduleModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.scheduleId,
    required this.organizationId,
    required this.topic,
    required this.participantId,
    required this.startTime,
    required this.duration,
    required this.isAllday,
    required this.address,
    required this.attachment,
    required this.description,
    required this.alertTime,
    required this.isRepeat,
    required this.isActive,
    required this.calender,
    required this.createTime,
    required this.updateTime,
  });
  late final int scheduleId;
  late final String organizationId;
  late final String topic;
  late final List<String> participantId;
  late final String startTime;
  late final int duration;
  late final bool isAllday;
  late final String address;
  late final List<String> attachment;
  late final String description;
  late final int alertTime;
  late final bool isRepeat;
  late final bool isActive;
  late final String calender;
  late final String createTime;
  late final String updateTime;

  Data.fromJson(Map<String, dynamic> json){
    scheduleId = json['scheduleId'];
    organizationId = json['organizationId'];
    topic = json['topic'];
    participantId = new List<String>.from(json['participantId']);
    startTime = json['startTime'];
    duration = json['duration'];
    isAllday = json['isAllday'];
    address = json['address'];
    attachment = new List<String>.from(json['attachment']);
    description = json['description'];
    alertTime = json['alertTime'];
    isRepeat = json['isRepeat'];
    isActive = json['isActive'];
    calender = json['calender'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['scheduleId'] = scheduleId;
    _data['organizationId'] = organizationId;
    _data['topic'] = topic;
    _data['participantId'] = participantId;
    _data['startTime'] = startTime;
    _data['duration'] = duration;
    _data['isAllday'] = isAllday;
    _data['address'] = address;
    _data['attachment'] = attachment;
    _data['description'] = description;
    _data['alertTime'] = alertTime;
    _data['isRepeat'] = isRepeat;
    _data['isActive'] = isActive;
    _data['calender'] = calender;
    _data['createTime'] = createTime;
    _data['updateTime'] = updateTime;
    return _data;
  }
}