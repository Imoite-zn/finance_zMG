import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_expense_budget_tracker_for_students/models/expense.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseListItem({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '₹', decimalDigits: 2);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getCategoryColor(expense.category).withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getCategoryIcon(expense.category),
            color: _getCategoryColor(expense.category),
            size: 20,
          ),
        ),
        title: Text(
          expense.category,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          DateFormat('MMM dd, yyyy').format(expense.date) +
              (expense.note != null ? '\n${expense.note}' : ''),
          maxLines: 2,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currencyFormat.format(expense.amount),
              style: const TextStyle(
                color: Color(0xFF1B4D3E), // Jungle green for expense amount
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('hh:mm a').format(expense.date),
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onLongPress: () => _showDeleteDialog(context),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Expense?',
          style: TextStyle(color: Colors.black87),
        ),
        content: Text(
          'Are you sure you want to delete this ${expense.category} expense?',
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF2E5A88)), // Grey-blue
            ),
          ),
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Expense deleted'),
                  backgroundColor: Color(0xFFB00020), // Error red
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFB00020)), // Error red
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Icons.restaurant;
      case 'transport': return Icons.directions_car;
      case 'entertainment': return Icons.movie;
      case 'education': return Icons.school;
      case 'shopping': return Icons.shopping_bag;
      case 'health': return Icons.health_and_safety;
      case 'utilities': return Icons.electric_bolt;
      default: return Icons.more_horiz;
    }
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
      default:
        return const Color(0xFF2E5A88); // Default grey-blue
    }
  }
}