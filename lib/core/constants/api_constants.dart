class ApiConstants {
  ApiConstants._();

  // Базовый URL (поменяйте на реальный адрес сервера Eldik Bank)
  // Для локального теста на Android эмуляторе часто используют 10.0.2.2
  static const String baseUrl = 'https://api.eldikbank.kg/v1';

  // Таймауты (время ожидания ответа)
  static const int receiveTimeout = 15000; // 15 секунд
  static const int connectionTimeout = 15000;

  // Эндпоинты (адреса конкретных запросов)
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';

  static const String accounts = '/accounts';
  static const String cards = '/cards';
  static const String transactions = '/transactions';
}