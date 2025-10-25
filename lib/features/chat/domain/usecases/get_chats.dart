import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/repositories/chat_repository.dart';

class GetChats {
  final ChatRepository chatRepository;

  GetChats(this.chatRepository);

  Future<List<ChatEntity>> call() async {
    return chatRepository.getChats();
  }

}