import 'package:chat/common/constants/constants.dart';
import 'package:chat/common/http/dio.dart';
import 'package:chat/features/chat/data/datasource/chat_datasource.dart';
import 'package:chat/features/chat/data/datasource/chat_ws_datasource.dart';
import 'package:chat/features/chat/data/repositories/chat_repository.dart';
import 'package:chat/features/chat/data/repositories/chat_ws_repository.dart';
import 'package:chat/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat/features/chat/domain/repositories/chat_ws_repository.dart';
import 'package:chat/features/chat/domain/usecases/connect_chat.dart';
import 'package:chat/features/chat/domain/usecases/disconnect_chat.dart';
import 'package:chat/features/chat/domain/usecases/get_chats.dart';
import 'package:chat/features/chat/domain/usecases/send_message.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final dio = createClient(accessToken);

  sl.registerFactory(() => ChatListBloc(
    getChats: sl<GetChats>()
  ));

  //USE CASES
  sl.registerLazySingleton(() => ConnectChat(sl<ChatWsRepository>()));
  sl.registerLazySingleton(() => DisconnectChat(sl<ChatWsRepository>()));
  sl.registerLazySingleton(() => SendMessage(sl<ChatWsRepository>()));
  sl.registerLazySingleton(() => GetChats(sl<ChatRepository>()));

  //Repository
  sl.registerLazySingleton<ChatWsRepository>(() => ChatWsRepositoryImpl(datasource: sl<ChatWsDatasource>()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(datasource: sl<ChatDatasource>()));

  //Data sources
  sl.registerLazySingleton<ChatDatasource>(
    () => ChatDatasourceImpl(dio: dio)
  );
  sl.registerLazySingleton<ChatWsDatasource>(
    () => ChatWsDatasourceImpl()
  );

}