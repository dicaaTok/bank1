import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Нужен для форматирования даты
import '../../core/constants/app_colors.dart';

// Модель для одной транзакции (пока упрощенная)
class Transaction {
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final bool isIncome;

  Transaction({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Заглушка: Список транзакций
  final List<Transaction> _transactions = [
    Transaction(title: "Супермаркет Глобус", category: "Покупки", amount: 1250, date: DateTime(2025, 11, 21), isIncome: false),
    Transaction(title: "Пополнение баланса", category: "Зарплата", amount: 55000, date: DateTime(2025, 11, 21), isIncome: true),
    Transaction(title: "Оплата ЖКХ", category: "Коммунальные", amount: 3500, date: DateTime(2025, 11, 20), isIncome: false),
    Transaction(title: "Перевод от клиента", category: "Поступление", amount: 4500, date: DateTime(2025, 11, 20), isIncome: true),
    Transaction(title: "Такси Я.Go", category: "Транспорт", amount: 180, date: DateTime(2025, 11, 19), isIncome: false),
    Transaction(title: "Кафе Pishkek", category: "Еда", amount: 890, date: DateTime(2025, 11, 19), isIncome: false),
    Transaction(title: "Снятие наличных", category: "Снятие", amount: 10000, date: DateTime(2025, 11, 18), isIncome: false),
  ];

  DateTime? _startDate;
  DateTime? _endDate;

  // Группировка транзакций по дате для отображения
  Map<String, List<Transaction>> get _groupedTransactions {
    final Map<String, List<Transaction>> grouped = {};
    for (var tx in _transactions) {
      // Ключ - дата в формате "21 Ноября 2025"
      final dateKey = DateFormat('d MMMM yyyy', 'ru').format(tx.date);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(tx);
    }
    return grouped;
  }

  // Обработчик выбора диапазона дат
  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      firstDate: DateTime(2023, 1),
      lastDate: DateTime.now(),
      locale: const Locale('ru', 'RU'),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
        // TODO: В будущем здесь будет фильтрация _transactions по датам
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Временно устанавливаем локаль, чтобы intl.DateFormat работал с русскими месяцами
    Intl.defaultLocale = 'ru';

    final groupedData = _groupedTransactions;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("История операций"),
      ),
      body: Column(
        children: [
          // Секция фильтров
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectDateRange,
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(_startDate != null
                        ? "${DateFormat('dd.MM.yy').format(_startDate!)} - ${DateFormat('dd.MM.yy').format(_endDate!)}"
                        : "Выбрать даты"),
                  ),
                ),
                const SizedBox(width: 10),
                // Кнопка Фильтра по Типу
                IconButton(
                  onPressed: () {
                    // TODO: Логика фильтрации по типу (доходы/расходы)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Открытие фильтра по типу...")),
                    );
                  },
                  icon: const Icon(Icons.filter_list),
                  color: AppColors.primary,
                ),
              ],
            ),
          ),

          // Список транзакций (сгруппированный по дням)
          Expanded(
            child: ListView.builder(
              itemCount: groupedData.keys.length,
              itemBuilder: (context, index) {
                final date = groupedData.keys.elementAt(index);
                final dayTransactions = groupedData[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок дня
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16),
                      child: Text(
                        date,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                    ),

                    // Список операций за этот день
                    ...dayTransactions.map((tx) => _buildTransactionItem(tx)).toList(),

                    const Divider(indent: 16, endIndent: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Виджет для одной транзакции
  Widget _buildTransactionItem(Transaction tx) {
    final color = tx.isIncome ? AppColors.secondary : AppColors.textPrimary;
    final sign = tx.isIncome ? "+" : "-";

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          tx.isIncome ? Icons.trending_up : Icons.trending_down,
          color: color,
        ),
      ),
      title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(tx.category),
      trailing: Text(
        "$sign ${NumberFormat.currency(locale: 'ru', symbol: 'с', decimalDigits: 0).format(tx.amount)}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      onTap: () {
        // TODO: Переход на детальный экран транзакции
        print("Нажата транзакция: ${tx.title}");
      },
    );
  }
}