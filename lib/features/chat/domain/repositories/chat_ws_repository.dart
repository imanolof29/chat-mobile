import 'package:chat/features/chat/domain/entities/message_entity.dart';

abstract class ChatWsRepository {
  Future<void> connect(String url);
  Future<void> disconnect();
  Future<void> sendMessage(String content);
  Stream<bool> get connectionStatus;
  Stream<MessageEntity> get message;
}