/// 联系人
class ContactModel {
  late final String id;
  String? phone;
  String? photo;
  String? name;

  ContactModel({required this.id, this.phone, this.photo, this.name});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    photo = json['photo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['name'] = this.name;
    return data;
  }
}
