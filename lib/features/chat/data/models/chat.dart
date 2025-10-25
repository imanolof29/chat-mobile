import 'package:chat/features/chat/data/models/participant.dart';

class Chat {
  final String id;
  final List<Participant> participants;
  final String createdAt;

  Chat({
    required this.id,
    required this.participants,
    required this.createdAt
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((participantJson) => Participant.fromJson(participantJson as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
    );
  }

}