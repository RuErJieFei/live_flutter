import 'package:meta/meta.dart';

@immutable
class MessageData {
  const MessageData({
    required this.id,
    required this.senderName,
    required this.profilePicture,
  });
  final String id;
  final String senderName;
  final String profilePicture;
}
