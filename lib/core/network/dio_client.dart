import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // Рекомендую добавить для логов
import '../constants/api_constants.dart';
import 'auth_interceptor.dart';

class DioClient {
  // Singleton (чтобы клиент был один на всё приложение)
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    // Базовые настройки
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    // Подключаем перехватчики
    dio.interceptors.add(AuthInterceptor());

    // Логгер (чтобы видеть запросы в консоли при разработке)
    // Нужно добавить в pubspec.yaml: pretty_dio_logger: ^1.3.1
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }

  // Геттер для удобного доступа
  Dio get instance => dio;
}