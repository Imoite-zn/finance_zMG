import 'package:flutter/material.dart';

class BudgetProgress extends StatelessWidget {
  final double spent;
  final double budget;

  const BudgetProgress({
    super.key,
    required this.spent,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    double ratio = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0;
    
    // Use theme colors for progress indicators
    Color progressColor;
    if (ratio < 0.7) {
      progressColor = const Color(0xFF4A7C59); // Lighter jungle green for good progress
    } else if (ratio < 0.9) {
      progressColor = const Color(0xFF8B7355); // Brown-orange for warning
    } else {
      progressColor = const Color(0xFFB00020); // Error red for over budget
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Progress',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDF2), // Light grey-blue background
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              height: 20,
              width: MediaQuery.of(context).size.width * ratio,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: progressColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  '${(ratio * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: ratio > 0.4 ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Spent: KES${spent.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Budget: KES${budget.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}