import 'package:chat/features/chat/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final MessageEntity message;

  const MessageBubble({super.key, required this.message});
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(message.content),
      ),
    );
  }

}