import 'package:chat/features/chat/domain/repositories/chat_ws_repository.dart';

class SendMessage {

  final ChatWsRepository chatRepository;

  SendMessage(this.chatRepository);

  Future<void> call(String content) async {
    return await chatRepository.sendMessage(content);
  }

}