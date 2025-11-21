import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';

// lib/main.dart

// ... (импорты)
import 'core/router/router.dart'; // Импортируем наш новый роутер

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Создаем экземпляр роутера
    final GoRouter router = buildRouter(context);

    return MaterialApp.router(
      title: 'Eldik Bank',
      theme: ThemeData(
        // ... ваша тема
        primarySwatch: Colors.blue,
      ),

      // 2. Используем GoRouter.router()
      routerConfig: router,
    );
  }
}