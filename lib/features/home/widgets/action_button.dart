import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Используем Column, чтобы текст был под иконкой
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Занимаем минимум места
        children: [
          // Контейнер для иконки
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16), // Закругленные углы
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // Легкая тень
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primary, // Синий цвет банка
              size: 28,
            ),
          ),
          const SizedBox(height: 8), // Отступ между иконкой и текстом
          // Текст под иконкой
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}