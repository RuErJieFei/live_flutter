class DeptModel {
  DeptModel({
    required this.pkId,
    required this.typeId,
    required this.parentId,
    required this.title,
    required this.userId,
    required this.photo,
    required this.name,
    required this.desc,
  });

  late final int pkId;
  late final List<int> typeId;
  late final List<int> parentId;
  late final String title;
  late final String userId;
  late final String photo;
  late final String name;
  late final String desc;

  DeptModel.fromJson(Map<String, dynamic> json) {
    pkId = json['pk_id'];
    typeId = List.castFrom<dynamic, int>(json['type_id']);
    parentId = List.castFrom<dynamic, int>(json['parent_id']);
    title = json['title'];
    userId = json['user_id'];
    photo = json['photo'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pk_id'] = pkId;
    _data['type_id'] = typeId;
    _data['parent_id'] = parentId;
    _data['title'] = title;
    _data['user_id'] = userId;
    _data['photo'] = photo;
    _data['name'] = name;
    _data['desc'] = desc;
    return _data;
  }
}
