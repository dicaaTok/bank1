import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Пытаемся достать токен из памяти телефона
    final accessToken = await _storage.read(key: 'access_token');

    // Если токен есть, добавляем его в заголовок (Header)
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Пропускаем запрос дальше
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Если сервер ответил 401 (Unauthorized), значит токен протух.
    // В будущем здесь можно добавить логику выхода из приложения (Logout)
    // или обновления токена (Refresh Token).
    if (err.response?.statusCode == 401) {
      // TODO: Логика логаута или рефреша
    }
    handler.next(err);
  }
}