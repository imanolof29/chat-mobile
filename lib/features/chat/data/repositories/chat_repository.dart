import 'package:chat/common/error/exceptions.dart';
import 'package:chat/features/chat/data/datasource/chat_datasource.dart';
import 'package:chat/features/chat/domain/entities/chat_entity.dart';
import 'package:chat/features/chat/domain/entities/participant_entity.dart';
import 'package:chat/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {

  final ChatDatasource datasource;

  ChatRepositoryImpl({required this.datasource});

  @override
  Future<List<ChatEntity>> getChats() async{
    try{
      final chats = await datasource.getChats();
      return chats.map((chat) => ChatEntity(id: chat.id, participants: chat.participants.map((participant) => ParticipantEntity(id: participant.id, username: participant.username, avatarUrl: participant.avatarUrl)).toList(), createdAt: chat.createdAt)).toList();
    }catch(error){
      throw ServerException(error.toString());
    }
  }
  
}