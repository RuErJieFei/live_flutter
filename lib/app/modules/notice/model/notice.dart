/**
 * notice通知公告
 */

class Notice {
  final String? updatedTime;
  final String? createdTime;
  final String? typeId;
  final num? id;
  final String? message;
  final String? noticeTime;

  Notice({
    this.updatedTime,
    this.createdTime,
    this.typeId,
    this.id,
    this.message,
    this.noticeTime,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      updatedTime: json['updatedTime'],
      createdTime: json['createdTime'],
      typeId: json['typeId'],
      id: json['id'],
      message: json['message'],
      noticeTime: json['noticeTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'updatedTime': updatedTime,
        'createdTime': createdTime,
        'typeId': typeId,
        'id': id,
        'message': message,
        'noticeTime': noticeTime,
      };
}
