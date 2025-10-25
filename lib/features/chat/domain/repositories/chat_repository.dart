import 'package:chat/features/chat/domain/entities/chat_entity.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> getChats();
}