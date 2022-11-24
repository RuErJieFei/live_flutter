class UserInfoModel {
  UserInfoModel({
    this.gender,
    this.email,
    this.id,
    this.phone,
    this.name,
    this.photo,
  });

  String? gender;
  String? email;
  String? id;
  String? phone;
  String? name;
  String? photo;

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    email = json['email'];
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['gender'] = gender;
    _data['email'] = email;
    _data['id'] = id;
    _data['phone'] = phone;
    _data['name'] = name;
    _data['photo'] = photo;
    return _data;
  }
}
