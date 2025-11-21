import 'package:flutter/material.dart';

class AppColors {
  // Приватный конструктор, чтобы случайно не создать экземпляр класса
  AppColors._();

  // Основные цвета бренда (замените на точные цвета из брендбука)
  static const Color primary = Color(0xFF0052CC); // Основной синий
  static const Color secondary = Color(0xFF00C853); // Зеленый (успех, деньги)

  // Фон
  static const Color scaffoldBackground = Color(0xFFF5F6FA); // Светло-серый фон
  static const Color white = Colors.white;

  // Текст
  static const Color textPrimary = Color(0xFF172B4D); // Почти черный
  static const Color textSecondary = Color(0xFF7A869A); // Серый текст

  // Ошибки и предупреждения
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFC107);

  // Элементы UI (границы, разделители)
  static const Color border = Color(0xFFDFE1E6);
  static const Color inputBackground = Color(0xFFFAFBFC);
}