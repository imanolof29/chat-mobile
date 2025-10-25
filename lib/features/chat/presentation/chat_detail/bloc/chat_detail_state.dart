import 'package:chat/features/chat/domain/entities/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatDetailInitial extends ChatDetailState {}

class ChatDetailConnecting extends ChatDetailState {}

class ChatDetailConnected extends ChatDetailState {

  final List<MessageEntity> messages;

  ChatDetailConnected(this.messages);

  @override
  List<Object?> get props => [messages];

}

class ChatDetailDisconnected extends ChatDetailState {}

class ChatDetailError extends ChatDetailState {
  final String error;

  ChatDetailError(this.error);

  @override
  List<Object?> get props => [error];

}