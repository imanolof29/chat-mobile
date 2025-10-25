import 'package:equatable/equatable.dart';

abstract class ChatDetailEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class ConnectChatEvent extends ChatDetailEvent {
  final String url;

  ConnectChatEvent(this.url);

  @override
  List<Object?> get props => [url];

}

class SendMessageEvent extends ChatDetailEvent {
  final String message;

  SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];

}

class DisconnectChatEvent extends ChatDetailEvent {}