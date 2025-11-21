import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Список экранов для каждой вкладки
  final List<Widget> _screens = [
    const HomeScreen(),
    const Center(child: Text("Платежи (В разработке)")), // Заглушка
    const Center(child: Text("История (В разработке)")), // Заглушка
    const Center(child: Text("Профиль (В разработке)")), // Заглушка
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFEEEFF0), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed, // Чтобы надписи не прыгали
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Главная"),
            BottomNavigationBarItem(icon: Icon(Icons.payments_outlined), label: "Платежи"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "История"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Профиль"),
          ],
        ),
      ),
    );
  }
}