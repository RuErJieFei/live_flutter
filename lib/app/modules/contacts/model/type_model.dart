class TypeModel {
  TypeModel({
    required this.pkId,
    required this.title,
    required this.deleteFlag,
    required this.createTime,
    required this.updateTime,
  });

  late final int pkId;
  late final String title;
  late final int deleteFlag;
  late final String createTime;
  late final String updateTime;

  TypeModel.fromJson(Map<String, dynamic> json) {
    pkId = json['pk_id'];
    title = json['title'];
    deleteFlag = json['delete_flag'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pk_id'] = pkId;
    _data['title'] = title;
    _data['delete_flag'] = deleteFlag;
    _data['create_time'] = createTime;
    _data['update_time'] = updateTime;
    return _data;
  }
}
