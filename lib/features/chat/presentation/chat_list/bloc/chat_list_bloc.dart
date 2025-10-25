import 'package:chat/features/chat/domain/usecases/get_chats.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_event.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  
  final GetChats getChats;

  ChatListBloc({
    required this.getChats
  }): super(ChatListInitial()){
    on<LoadChats>(_onLoadChats);
  }

  Future<void> _onLoadChats(
    LoadChats event,
    Emitter<ChatListState> emit
  ) async {
    emit(ChatListLoading());
    try{
      final chats = await getChats.call();
      emit(ChatListLoaded(chats));
    }catch(error){
      emit(ChatListError(error.toString()));
    }
  }

}