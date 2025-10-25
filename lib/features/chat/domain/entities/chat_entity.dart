import 'package:chat/features/chat/domain/entities/participant_entity.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable{
  final String id;
  final List<ParticipantEntity> participants;
  final String createdAt;

  const ChatEntity({
    required this.id,
    required this.participants,
    required this.createdAt
  });

  @override
  List<Object?> get props => [id, participants, createdAt];

}