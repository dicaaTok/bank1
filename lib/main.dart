import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';

void main() {
  runApp(const EldikBankApp());
}

class EldikBankApp extends StatelessWidget {
  const EldikBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eldik Bank',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Подключим тему ниже
      home: const LoginScreen(), // Стартуем с логина
    );
  }
}