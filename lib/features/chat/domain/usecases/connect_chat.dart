import 'package:chat/features/chat/domain/repositories/chat_ws_repository.dart';

class ConnectChat {
  final ChatWsRepository chatRepository;

  ConnectChat(this.chatRepository);

  Future<void> call(String url) async {
    return await chatRepository.connect(url);
  }

}