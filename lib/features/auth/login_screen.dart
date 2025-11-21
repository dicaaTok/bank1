import 'package:flutter/material.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/custom_input_field.dart';
import '../home/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Вход в Eldik Bank",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Управляйте финансами легко", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),

              // Поле Логина
              // Поле Логина
              CustomInputField(
                controller: _loginController,
                labelText: "Номер телефона или ИНН",
                prefixIcon: const Icon(Icons.person_outline),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
// Поле Пароля
              CustomInputField(
                controller: _passwordController,
                labelText: "Пароль",
                obscureText: !_isPasswordVisible,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Забыли пароль?")),
              ),
              const SizedBox(height: 20),

              // Кнопка Входа
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
                child: const Text("Войти", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}