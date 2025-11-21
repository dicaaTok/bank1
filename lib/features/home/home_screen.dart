import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/credit_card_widget.dart';
import 'widgets/action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Добрый день,", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text("Урмат", style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Секция: Мои карты (горизонтальный скролл)
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  CreditCardWidget(balance: "45 200 с", number: "**** 4123", holder: "URMAT A."),
                  CreditCardWidget(balance: "120 \$", number: "**** 8899", holder: "URMAT A."),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Секция: Быстрые действия
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Равномерное распределение
                      crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание по верху
                      children: [
                        ActionButton(
                          icon: Icons.sync_alt, // Иконка перевода
                          label: "Перевод",
                          onTap: () {
                            // Логика перехода на экран переводов
                            print("Нажат Перевод");
                          },
                        ),
                  _buildActionIcon(Icons.send, "Перевод"),
                  _buildActionIcon(Icons.add_card, "Пополнить"),
                  _buildActionIcon(Icons.payment, "Оплата"),
                  _buildActionIcon(Icons.qr_code_scanner, "QR"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Секция: Последние операции
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text("История операций", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),

            // Заглушка списка операций
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true, // Важно, чтобы список не конфликтовал со скроллом страницы
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
                  ),
                  title: const Text("Супермаркет Глобус", style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: const Text("Сегодня, 12:30"),
                  trailing: const Text("-1 250 с", style: TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод для кнопок действий
  Widget _buildActionIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}