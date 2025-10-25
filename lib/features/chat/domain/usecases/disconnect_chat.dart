import 'package:chat/features/chat/domain/repositories/chat_ws_repository.dart';

class DisconnectChat {
  final ChatWsRepository chatRepository;

  DisconnectChat(this.chatRepository);

  Future<void> call() async {
    return await chatRepository.disconnect();
  }

}