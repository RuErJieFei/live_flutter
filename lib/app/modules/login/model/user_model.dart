class UserModel {
  String? gender;
  String? email;
  String? id;
  String? phone;
  String? name;
  String? photo;
  List<String>? roleList;
  String? sno;
  String? classes;
  String? college;

  UserModel(
      {this.gender,
      this.email,
      this.id,
      this.phone,
      this.name,
      this.photo,
      this.roleList,
      this.sno,
      this.classes,
      this.college});

  UserModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    email = json['email'];
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    photo = json['photo'];
    roleList = json['roleList'].cast<String>();
    sno = json['sno'];
    classes = json['classes'];
    college = json['college'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['roleList'] = this.roleList;
    data['sno'] = this.sno;
    data['classes'] = this.classes;
    data['college'] = this.college;
    return data;
  }
}
