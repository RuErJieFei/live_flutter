import 'package:meta/meta.dart';

@immutable
class ScheduleData {
  const ScheduleData( {
   this.participateName,
    required this.address,
     this.scheduleDate,
    required this.time,
    required this.topic,
     this.organizerName,
     this.profilePicture,
    this.description,
  this.durationTime
  });
  final String? participateName;
  final String address;
  final String topic;
  final DateTime? scheduleDate;
  final  int?    durationTime ;
  final String? description;
  final String time;
  final String? organizerName;
  final String? profilePicture;
}
