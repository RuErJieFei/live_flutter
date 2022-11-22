class ScheduleModelPage {
  ScheduleModelPage({
    required this.code,
    required this.msg,
    required this.data,
  });
  late final int code;
  late final String msg;
  late final Data data;

  ScheduleModelPage.fromJson(Map<String, dynamic> json){
    code = json['code'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.records,
    required this.total,
    required this.size,
    required this.current,
    required this.orders,
    required this.optimizeCountSql,
    required this.searchCount,
    this.countId,
    this.maxLimit,
    required this.pages,
  });
  late final List<Records> records;
  late final int total;
  late final int size;
  late final int current;
  late final List<dynamic> orders;
  late final bool optimizeCountSql;
  late final bool searchCount;
  late final Null countId;
  late final Null maxLimit;
  late final int pages;

  Data.fromJson(Map<String, dynamic> json){
    records = List.from(json['records']).map((e)=>Records.fromJson(e)).toList();
    total = json['total'];
    size = json['size'];
    current = json['current'];
    orders = List.castFrom<dynamic, dynamic>(json['orders']);

    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = null;
    maxLimit = null;
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['records'] = records.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['size'] = size;
    _data['current'] = current;
    _data['orders'] = orders;
    _data['optimizeCountSql'] = optimizeCountSql;
    _data['searchCount'] = searchCount;
    _data['countId'] = countId;
    _data['maxLimit'] = maxLimit;
    _data['pages'] = pages;
    return _data;
  }
}

class Records {
  Records({
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

  Records.fromJson(Map<String, dynamic> json){
    scheduleId = json['scheduleId'];
    organizationId = json['organizationId'];
    topic = json['topic'];
    participantId = List.castFrom<dynamic, String>(json['participantId']);
    startTime = json['startTime'];
    duration = json['duration'];
    isAllday = json['isAllday'];
    address = json['address'];
    attachment = List.castFrom<dynamic, String>(json['attachment']);
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