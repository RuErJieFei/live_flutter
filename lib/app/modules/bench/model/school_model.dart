/// FileName school_model
///
/// @Author chenrongqi
/// @Date 2022/11/29 19:40
///
/// @Description TODO
import 'package:meta/meta.dart';

@immutable
class SchoolData {
  SchoolData(
      {required this.id,
      required this.userId,
      required this.healthyImageUrl,
      this.admissionTime,
      required this.tripImageUrl,
      required this.peerHealthy,
      required this.riskRegion,
      required this.sicken});
  late final int? id;
  late final String userId;
  late final String healthyImageUrl;
  late final String? admissionTime;
  late final String tripImageUrl;
  late final bool peerHealthy;
  late final bool riskRegion;
  late final bool sicken;

  SchoolData.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    userId = json['userId'];
    healthyImageUrl = json['healthyImageUrl'];
    admissionTime = json['admissionTime'];
    tripImageUrl = json['tripImageUrl'];
    peerHealthy = json['peerHealthy'];
    riskRegion = json['riskRegion'];
    sicken = json['sicken'];
  }

  Map<String, dynamic>? toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['healthyImageUrl'] = healthyImageUrl;
    _data['admissionTime'] = admissionTime;
    _data['tripImageUrl'] = tripImageUrl;
    _data['peerHealthy'] = peerHealthy;
    _data['riskRegion'] = riskRegion;
    _data['sicken'] = sicken;
    return _data;
  }
}
