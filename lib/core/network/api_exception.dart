import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  // Метод, который превращает ошибки Dio в понятные нам ошибки
  static ApiException fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Время ожидания истекло. Проверьте интернет.");
      case DioExceptionType.connectionError:
        return ApiException(message: "Нет соединения с интернетом.");
      case DioExceptionType.badResponse:
      // Здесь мы берем текст ошибки прямо от сервера (если бэкенд его присылает)
        final message = error.response?.data['message'] ?? "Произошла ошибка сервера";
        return ApiException(message: message, statusCode: error.response?.statusCode);
      default:
        return ApiException(message: "Неизвестная ошибка: ${error.message}");
    }
  }

  @override
  String toString() => message;
}