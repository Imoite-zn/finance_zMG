import 'package:flutter/material.dart';
import 'package:smart_expense_budget_tracker_for_students/models/expense.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'No data to display',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    // Group expenses by category
    final Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals.update(
        expense.category,
            (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Spending by Category',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: categoryTotals.entries.map((entry) {
                    return PieChartSectionData(
                      value: entry.value,
                      title: '${(entry.value / expenses.fold(0, (sum, e) => sum + e.amount) * 100).toStringAsFixed(1)}%',
                      color: _getCategoryColor(entry.key),
                      radius: 40,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: categoryTotals.entries.map((entry) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(entry.key),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      entry.key,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return const Color(0xFF2E5A88); // Grey-blue
      case 'transport':
        return const Color(0xFF1B4D3E); // Jungle green
      case 'entertainment':
        return const Color(0xFF4A7C59); // Lighter jungle green
      case 'education':
        return const Color(0xFF5B7A9A); // Medium grey-blue
      case 'shopping':
        return const Color(0xFF3D6B7A); // Blue-green
      case 'health':
        return const Color(0xFF6B8E8E); // Teal
      case 'utilities':
        return const Color(0xFF8B7355); // Brown
      case 'other':
        return const Color(0xFF9BA3A8); // Light grey
      default:
        return const Color(0xFF2E5A88); // Default grey-blue
    }
  }
}