import 'package:equatable/equatable.dart';

class ParticipantEntity extends Equatable{
  final String id;
  final String username;
  final String avatarUrl;

  const ParticipantEntity({
    required this.id,
    required this.username,
    required this.avatarUrl
  });

  @override
  List<Object?> get props => [id, username, avatarUrl];

}