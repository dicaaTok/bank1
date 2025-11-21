import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'p2p_transfer_screen.dart'; // Нужен для перехода

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Платежи и переводы"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Поле Поиска (для поиска по услугам: "свет", "интернет")
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Поиск по услугам, получателям",
                  prefixIcon: Icon(Icons.search),
                  // theme/app_theme.dart обеспечивает красивый вид
                ),
              ),
            ),

            // Секция: Шаблоны (Часто используемые платежи)
            const Text("Мои шаблоны", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            _buildTemplatesList(),

            const SizedBox(height: 30),

            // Секция: Категории платежей
            const Text("Категории", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            _buildPaymentGrid(context),
          ],
        ),
      ),
    );
  }

  // --- Вспомогательные виджеты ---

  Widget _buildTemplatesList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTemplateItem(Icons.person, "Урмат", "Последний перевод", () {}),
          _buildTemplateItem(Icons.phone_android, "Мобильный", "+996 700...", () {}),
          _buildTemplateItem(Icons.lightbulb_outline, "Электроэнергия", "По адресу", () {}),
          _buildTemplateItem(Icons.add_circle_outline, "Новый", "Создать шаблон", () {}),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentGrid(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.phone_android, 'label': 'Мобильная связь', 'target': null},
      {'icon': Icons.flash_on, 'label': 'Электроэнергия', 'target': null},
      {'icon': Icons.wifi, 'label': 'Интернет/ТВ', 'target': null},
      {'icon': Icons.water_drop_outlined, 'label': 'Коммунальные', 'target': null},
      {'icon': Icons.person, 'label': 'Перевод по номеру', 'target': const P2PTransferScreen()},
      {'icon': Icons.account_balance, 'label': 'На счет в другом банке', 'target': null},
      {'icon': Icons.local_car_wash_outlined, 'label': 'Штрафы ГАИ', 'target': null},
      {'icon': Icons.school_outlined, 'label': 'Образование', 'target': null},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 столбца
        childAspectRatio: 0.9, // Соотношение сторон элемента
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = categories[index];
        return GestureDetector(
          onTap: () {
            if (item['target'] != null) {
              Navigator.push(context, MaterialPageRoute(builder: (c) => item['target']));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Переход на ${item['label']}")),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['icon'], color: AppColors.primary, size: 32),
                const SizedBox(height: 8),
                Text(
                  item['label'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}