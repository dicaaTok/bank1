import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CreditCardWidget extends StatelessWidget {
  final String balance;
  final String number;
  final String holder;

  const CreditCardWidget({
    super.key,
    required this.balance,
    required this.number,
    required this.holder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Фиксированная ширина для карусели
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Градиент для красоты (как у Visa/Mastercard)
        gradient: const LinearGradient(
          colors: [Color(0xFF0052CC), Color(0xFF2684FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Eldik Bank", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Icon(Icons.nfc, color: Colors.white70), // Значок бесконтактной оплаты
            ],
          ),
          const SizedBox(height: 20),
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(number, style: const TextStyle(color: Colors.white70, fontSize: 16, letterSpacing: 1.5)),
              Text(holder.toUpperCase(), style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}