import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class P2PTransferScreen extends StatefulWidget {
  const P2PTransferScreen({super.key});

  @override
  State<P2PTransferScreen> createState() => _P2PTransferScreenState();
}

class _P2PTransferScreenState extends State<P2PTransferScreen> {
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCard = "Моя карта **** 4123 (45 200 с)"; // Выбранная карта

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Перевод по номеру"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Секция 1: Выбор карты (откуда спишем)
            _buildCardSelector(),
            const SizedBox(height: 20),

            // Секция 2: Ввод номера получателя
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Номер телефона получателя",
                hintText: "Например, +996 700 123 456",
                prefixIcon: const Icon(Icons.phone_android),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contact_page_outlined),
                  onPressed: () {
                    // TODO: Логика открытия контактов
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Открытие контактов...")),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Секция 3: Ввод суммы
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Сумма перевода (в сомах)",
                prefixIcon: Icon(Icons.monetization_on_outlined),
              ),
            ),
            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Комиссия: 0 сом", style: TextStyle(color: AppColors.secondary)),
            ),

            const Spacer(), // Отталкиваем кнопку вниз

            // Кнопка Перевода
            ElevatedButton(
              onPressed: () {
                // TODO: Реальная логика перевода
                print("Перевод ${_amountController.text} на ${_phoneController.text}");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Инициирован перевод...")),
                );
              },
              child: const Text("Перевести", style: TextStyle(color: AppColors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Списать с карты", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 4),
              Text(_selectedCard, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}