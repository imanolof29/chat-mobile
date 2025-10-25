import 'package:equatable/equatable.dart';

abstract class ChatListEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatListEvent {}