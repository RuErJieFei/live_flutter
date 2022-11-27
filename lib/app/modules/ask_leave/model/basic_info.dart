class BasicInfo {
  String? sno;
  String? name;
  String? gender;
  String? phone;
  String? college;
  String? classes;
  String? grade;
  String? teacherName;
  String? teacherPhone;
  String? address;

  BasicInfo(
      {this.college,
      this.gender,
      this.teacherName,
      this.phone,
      this.sno,
      this.classes,
      this.grade,
      this.name,
      this.teacherPhone,
      this.address});

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
        college: json['college'],
        gender: json['gender'],
        teacherName: json['teacherName'],
        phone: json['phone'],
        sno: json['sno'],
        classes: json['classes'],
        grade: json['grade'],
        name: json['name'],
        teacherPhone: json['teacherPhone'],
        address: json['address']);
  }

  Map<String, dynamic> toCusJson() => {
        '学号': sno,
        '姓名': name,
        '性别': gender == "M" ? "男" : "女",
        '电话': phone,
        '学院': college,
        '班级': classes,
        '现在年级': grade,
        '班主任姓名': teacherName,
        '班主任电话': teacherPhone,
        '住宿地址': address
      };

  Map<String, dynamic> toJson() => {
        'college': college,
        'gender': gender,
        'teacherName': teacherName,
        'phone': phone,
        'sno': sno,
        'classes': classes,
        'grade': grade,
        'name': name,
        'teacherPhone': teacherPhone,
        'address': address
      };
}
