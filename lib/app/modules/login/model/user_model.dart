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
  String? address;
  String? teacherPhone;
  String? teacherName;

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
      this.college,
      this.address,
      this.teacherPhone,
      this.teacherName});

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
    address = json['address'];
    teacherPhone = json['teacherPhone'];
    teacherName = json['teacherName'];
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
    data['address'] = this.address;
    data['teacherPhone'] = this.teacherPhone;
    data['teacherName'] = this.teacherName;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{gender: $gender, email: $email, id: $id, phone: $phone, name: $name, photo: $photo, roleList: $roleList, sno: $sno, classes: $classes, college: $college, address: $address, teacherPhone: $teacherPhone, teacherName: $teacherName}';
  }
}
