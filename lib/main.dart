import 'package:chat/features/chat/presentation/chat_detail/bloc/chat_detail_bloc.dart';
import 'package:chat/features/chat/presentation/chat_list/bloc/chat_list_bloc.dart';
import 'package:chat/features/chat/presentation/chat_list/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/common/di/injector.dart' as di;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<ChatListBloc>()),
          BlocProvider(create: (_) => di.sl<ChatDetailBloc>()) 
        ], 
        child: ChatListScreen()
      )
    );
  }
}
