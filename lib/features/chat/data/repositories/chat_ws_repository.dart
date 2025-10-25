import 'package:chat/common/error/exceptions.dart';
import 'package:chat/features/chat/data/datasource/chat_ws_datasource.dart';
import 'package:chat/features/chat/domain/entities/message_entity.dart';
import 'package:chat/features/chat/domain/repositories/chat_ws_repository.dart';

class ChatWsRepositoryImpl implements ChatWsRepository{

  final ChatWsDatasource datasource;

  ChatWsRepositoryImpl({
    required this.datasource
  });

  @override
  Future<void> connect(String url) async{
    try{
      await datasource.connect(url);
    }catch(error){
      throw ServerException(error.toString());
    }
  }

  @override
  Stream<bool> get connectionStatus => datasource.connectionStatus;

  @override
  Future<void> disconnect() async{
    await datasource.disconnect();
  }

  @override
  Stream<MessageEntity> get message => datasource.messages;

  @override
  Future<void> sendMessage(String content) async{
    try{
      await datasource.sendMessage(content);
    }catch(error){
      throw ServerException(error.toString());
    }
  }
  
}