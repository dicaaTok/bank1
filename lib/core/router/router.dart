// lib/core/router/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Понадобится позже для BLoC
// import 'package:eldikbank/features/auth/auth_bloc.dart'; // Понадобится позже

// Импортируем заглушки для экранов, которые мы будем использовать
// Я исправил пути импортов, предполагая, что они находятся в папке 'presentation'
import '../../features/auth/login_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/main_screen.dart';
import '../../features/payments/payments_screen.dart';
import '../../features/profile/profile_screen.dart'; // Путь может отличаться

// 1. Константы для путей
abstract class AppRoutes {
  static const String root = '/';
  static const String login = '/login';
  // Вложенные пути для BottomNavigationBar
  static const String home = 'home';
  static const String payments = 'payments';
  static const String history = 'history';
  static const String profile = 'profile';
}


// 2. Главный конфигуратор GoRouter
GoRouter buildRouter(BuildContext context) {

  // ВАЖНО: Это будет заменено реальной проверкой состояния AuthBloc.
  const bool isAuthenticated = false;

  return GoRouter(
    // Начинаем с экрана входа, чтобы убедиться, что он работает
    initialLocation: AppRoutes.login,

    // 3. Логика перенаправления (ВРЕМЕННО ЗАКОММЕНТИРОВАНА)
    // Мы комментируем этот блок, чтобы кнопка "Войти" могла работать.
    // Когда мы внедрим AuthBloc, мы вернем этот redirect и изменим логику.
    /*
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isLoggingIn) {
        // Если НЕ авторизован и пытается попасть НЕ на логин -> отправляем на логин
        return AppRoutes.login;
      }

      if (isAuthenticated && isLoggingIn) {
        // Если авторизован и пытается попасть на логин -> отправляем в главный раздел
        return AppRoutes.root;
      }

      // Иначе оставляем на том же месте
      return null;
    },
    */

    routes: <RouteBase>[
      // Маршрут для экрана входа (LoginScreen)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // 4. ShellRoute для Главного Экрана с BottomNavigationBar (MainScreen)
      ShellRoute(
        builder: (context, state, child) {
          // MainScreen принимает дочерний виджет, который будет отображаться в теле
          return MainScreen(child: child);
        },
        routes: <RouteBase>[
          // Вложенные маршруты для BottomNavigationBar
          GoRoute(
            // path: AppRoutes.root, (Используем '/')
            path: '/',
            name: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/${AppRoutes.payments}',
            name: AppRoutes.payments,
            builder: (context, state) => const PaymentsScreen(),
          ),
          GoRoute(
            path: '/${AppRoutes.history}',
            name: AppRoutes.history,
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/${AppRoutes.profile}',
            name: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}