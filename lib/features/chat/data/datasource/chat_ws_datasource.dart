import 'dart:async';

import 'package:chat/common/error/exceptions.dart';
import 'package:chat/features/chat/domain/entities/message_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatWsDatasource{
  Future<void> connect(String url);
  Future<void> disconnect();
  Future<void> sendMessage(String content);
  Stream<bool> get connectionStatus;
  Stream<MessageEntity> get messages;
}

class ChatWsDatasourceImpl implements ChatWsDatasource {

  WebSocketChannel? _channel;
  final StreamController<bool> _connectionController = StreamController.broadcast();
  final StreamController<MessageEntity> _messageController = StreamController.broadcast();

  @override
  Future<void> connect(String url) async{
    try{
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _connectionController.add(true);
      _channel!.stream.listen(
        (data) {
          
        },
        onError: (error) {
          _connectionController.add(false);
          throw ConnectionException(error.toString());
        },
        onDone: () {
          _connectionController.add(false);
        }
      );
    }catch(error){
      _connectionController.add(false);
      throw ConnectionException(error.toString());
    }
  }

  @override
  Stream<bool> get connectionStatus => _connectionController.stream;

  @override
  Stream<MessageEntity> get messages => _messageController.stream;

  @override
  Future<void> disconnect() async{
    await _channel?.sink.close();
    _channel = null;
    _connectionController.add(false);
  }
  
  @override
  Future<void> sendMessage(String content) async{
    if(_channel == null || _channel!.closeCode != null) {
      throw ConnectionException('Not connected');
    }
    _channel!.sink.add(content);
    _messageController.add(MessageEntity(content: content));
  }
  
}