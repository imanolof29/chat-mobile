import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_bloc.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_event.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget{
  const ChatListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatListScreenState();

}

class _ChatListScreenState extends State<ChatListScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ChatListBloc>().add(LoadChats());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats")
      ),
      body: BlocBuilder<ChatListBloc, ChatListState>(
        builder: (context, state) {
          if(state is ChatListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is ChatListLoaded) {
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return ListTile(
                  title: Text(chat.participants.first.username),
                );
              },
            );
          }else if(state is ChatListError) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        }
      ),
    );
  }
  
}