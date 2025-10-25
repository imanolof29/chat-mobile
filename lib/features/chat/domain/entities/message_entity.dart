import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable{
  final String content;
  const MessageEntity({
    required this.content
  });

  @override
  List<Object?> get props => [content];

}