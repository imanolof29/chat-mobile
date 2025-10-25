import 'package:chat/common/constants/constants.dart';
import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_event.dart';
import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_state.dart';
import 'package:chat/features/chat/presentation/chat_detail/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatDetailScreenState();

}

class _ChatDetailScreenState extends State<ChatDetailScreen> {

  final TextEditingController _messageController = TextEditingController();
  final String _url = wsUrl;

  @override
  void initState() {
    super.initState();
    context.read<ChatDetailBloc>().add(ConnectChatEvent("$_url/chat"));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat detail"),
      ),
      body: BlocBuilder<ChatDetailBloc, ChatDetailState>(
        builder: (context, state) {
          if(state is ChatDetailConnecting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is ChatDetailConnected) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index){
                final message = state.messages[index];
                return MessageBubble(message: message);
              }
            );
          }else if (state is ChatDetailError) {
            return Center(
              child: Text(state.error),
            );
          }else if(state is ChatDetailDisconnected) {
            return Center(
              child: Text('Disconnected'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Mensaje...'),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    if(_messageController.text.isEmpty) return;
                    context.read<ChatDetailBloc>().add(SendMessageEvent(_messageController.text));
                    _messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ), 
          );
        }
      ),
    );
  }
  
}