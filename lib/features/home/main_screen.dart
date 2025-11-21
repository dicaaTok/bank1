// lib/features/dashboard/presentation/main_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/router.dart'; // Импортируем пути

class MainScreen extends StatefulWidget {
  // 1. Child — это текущий экран (Home, Payments, History, Profile), 
  // переданный от GoRouter через ShellRoute.
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // Сопоставление индекса BottomNavigationBar с соответствующим маршрутом GoRouter
  final List<String> _routePaths = const [
    AppRoutes.root,
    AppRoutes.payments,
    AppRoutes.history,
    AppRoutes.profile,
  ];

  // Функция для навигации при нажатии на элемент BottomNavigationBar
  void _onItemTapped(int index) {
    // Используем context.go для перехода к новому маршруту
    context.go('/${_routePaths[index]}');
  }

  // Функция для определения активного индекса на основе текущего URL
  int _calculateSelectedIndex(BuildContext context) {
    // Получаем текущий URL/локацию из GoRouter
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    // Определяем, какой из наших путей активен
    if (location.contains(AppRoutes.payments)) return 1;
    if (location.contains(AppRoutes.history)) return 2;
    if (location.contains(AppRoutes.profile)) return 3;

    // Если ни один из вложенных путей не совпал, это корневой путь (home)
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // Определяем, какая вкладка должна быть активной (подсвечена)
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      // Тело Scaffold всегда отображает дочерний виджет, переданный от ShellRoute
      body: widget.child,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Чтобы избежать анимации при 4+ элементах
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Платежи'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'История'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],

        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}