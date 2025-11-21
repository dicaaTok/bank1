// lib/features/auth/presentation/login_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Для навигации через контекст
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  // Переменная для управления видимостью пароля
  bool _isPasswordVisible = false;

  // Временная заглушка для состояния загрузки
  bool _isLoading = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Временная функция обработки входа (до BLoC) ---
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Имитация процесса загрузки
      setState(() {
        _isLoading = true;
      });

      // В реальном приложении здесь будет вызов BLoC:
      // context.read<AuthBloc>().add(LoginRequested(
      //   login: _loginController.text,
      //   password: _passwordController.text,
      // ));

      // Имитация задержки (успешный вход)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        // Успешный вход -> переход на главный экран (корень ShellRoute)
        context.go('/');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80), // Отступ сверху

                  // Заголовок
                  const Text(
                    "Вход в Eldik Bank",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "Управляйте финансами легко",
                      style: TextStyle(color: Colors.grey)
                  ),
                  const SizedBox(height: 40),

                  //

                  //[Image of Modern Mobile Banking Login Screen UI]


                  // Поле Логина
                  CustomInputField( // <-- Теперь здесь всё чисто
                    controller: _loginController,
                    labelText: "Номер телефона или ИНН",
                    prefixIcon: const Icon(Icons.person_outline),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите логин';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Поле Пароля
                  CustomInputField(
                    controller: _passwordController,
                    labelText: "Пароль",
                    obscureText: !_isPasswordVisible,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите пароль';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                  ),

                  // Кнопка "Забыли пароль?"
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: const Text("Забыли пароль?")),
                  ),
                  const SizedBox(height: 20),

                  // Кнопка Входа (PrimaryButton)
                  PrimaryButton(
                    text: "Войти",
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}