// lib/core/router/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Понадобится позже для BLoC
// import 'package:eldikbank/features/auth/auth_bloc.dart'; // Понадобится позже

// Импортируем заглушки для экранов, которые мы будем использовать
import '../../features/auth/login_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/main_screen.dart';
import '../../features/payments/payments_screen.dart';
import '../../features/profile/profile_screen.dart';

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
  // 💡 ВАЖНО: Это временная заглушка для проверки авторизации.
  // Позже мы заменим 'false' на фактическую проверку состояния AuthBloc.
  const bool isAuthenticated = false;

  return GoRouter(
    initialLocation: AppRoutes.root,

    // 3. Логика перенаправления (для защиты закрытых экранов)
    redirect: (BuildContext context, GoRouterState state) {
      // Проверяем, куда хочет попасть пользователь
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

    routes: <RouteBase>[
      // Маршрут для экрана входа (LoginScreen)
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // 4. ShellRoute для Главного Экрана с BottomNavigationBar (MainScreen)
      // MainScreen будет "оболочкой", которая держит BottomNavigationBar.
      ShellRoute(
        builder: (context, state, child) {
          // MainScreen принимает дочерний виджет, который будет отображаться в теле
          return MainScreen(child: child);
        },
        routes: <RouteBase>[
          // Вложенные маршруты для BottomNavigationBar
          GoRoute(
            path: AppRoutes.root, // Слэш означает путь к корневому элементу ShellRoute
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