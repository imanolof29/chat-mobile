import 'package:chat/features/chat/data/models/chat.dart';
import 'package:dio/dio.dart';

abstract class ChatDatasource {
  Future<List<Chat>> getChats();
}

class ChatDatasourceImpl implements ChatDatasource {

  final Dio dio;

  ChatDatasourceImpl({
    required this.dio
  });

  @override
  Future<List<Chat>> getChats() async {
    try {
      final response = await dio.get('/chats');
      
      if (response.statusCode == 200) {
        final List<dynamic> chatsJson = response.data as List<dynamic>;
        return chatsJson
            .map((chatJson) => Chat.fromJson(chatJson as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load chats',
        );
      }
    } on DioException catch (e) {
      throw Exception('Error fetching chats: ${e.message}');
    } catch (error) {
      throw Exception('Unexpected error: $error');
    }
  }
  
}