import 'package:chat/common/constants/constants.dart';
import 'package:dio/dio.dart';

Dio createClient(String accessToken) {
  final dio = Dio(
    BaseOptions(
      baseUrl: url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3)
    )
  );
  return dio;
}