import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatListState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ChatListInitial extends ChatListState{}

class ChatListLoading extends ChatListState{}

class ChatListLoaded extends ChatListState {
  final List<ChatEntity> chats;

  ChatListLoaded(this.chats);

  @override
  List<Object?> get props => [chats];

}

class ChatListError extends ChatListState{

  final String error;

  ChatListError(this.error);

  @override
  List<Object?> get props => [error];

}