import 'dart:async';

import 'package:chat/features/chat/domain/entities/message_entity.dart';
import 'package:chat/features/chat/domain/usecases/connect_chat.dart';
import 'package:chat/features/chat/domain/usecases/disconnect_chat.dart';
import 'package:chat/features/chat/domain/usecases/send_message.dart';
import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_event.dart';
import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ConnectChat connectChat;
  final DisconnectChat disconnectChat;
  final SendMessage sendMessage;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _connectionSubscription;

  final List<MessageEntity> _messages = [];
  bool _isConnected = false;

  ChatDetailBloc({
    required this.connectChat,
    required this.disconnectChat,
    required this.sendMessage
  }) : super(ChatDetailInitial()) {
    on<ConnectChatEvent>(_onConnect);
    on<DisconnectChatEvent>(_onDisconnect);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onConnect(
    ConnectChatEvent event,
    Emitter<ChatDetailState> emit
  ) async {
    try{
      await connectChat(event.url);
      _connectionSubscription = connectChat.chatRepository.connectionStatus.listen((status) {
        _isConnected = status;
        if(!status) {
          add(DisconnectChatEvent());
        }
      });
      _messageSubscription = connectChat.chatRepository.message.listen((message) {
        _messages.add(message);
      });
      emit(ChatDetailConnected(List.from(_messages)));
    }catch(error){
      emit(ChatDetailError(error.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatDetailState> emit
  ) async {
    if(!_isConnected) {
      emit(ChatDetailError('Not connected'));
      return;
    }
    try{
      await sendMessage(event.message);
    }catch(error){
      emit(ChatDetailError(error.toString()));
    }
  }

  Future<void> _onDisconnect(
    DisconnectChatEvent event,
    Emitter<ChatDetailState> emit
  ) async{
    await disconnectChat();
    emit(ChatDetailDisconnected());
  }

  @override
  Future<void> close() async{
    _messageSubscription?.cancel();
    _connectionSubscription?.cancel();
    await disconnectChat();
    return super.close();
  }

}