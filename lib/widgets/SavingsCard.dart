import 'package:flutter/material.dart';
import '../models/savings_goal.dart';

class SavingsCard extends StatelessWidget {
  final SavingsGoal goal;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const SavingsCard({
    super.key,
    required this.goal,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final progress = goal.progressPercentage;
    final daysRemaining = goal.targetDate.difference(DateTime.now()).inDays;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E5A88).withValues(alpha: 0.1), // Grey-blue shadow
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    goal.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: onDelete,
                    color: const Color(0xFFB00020), // Error red
                  ),
              ],
            ),

            if (goal.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  goal.description!,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),

            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFE8EDF2), // Light grey-blue background
              color: progress > 0.75
                  ? const Color(0xFF4A7C59) // Lighter jungle green for good progress
                  : progress > 0.5
                  ? const Color(0xFF2E5A88) // Grey-blue for medium progress
                  : const Color(0xFF8B7355), // Brown for low progress
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${goal.savedAmount.toStringAsFixed(2)} saved',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '₹${goal.targetAmount.toStringAsFixed(2)} target',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(progress * 100).toStringAsFixed(1)}% completed',
                  style: const TextStyle(
                    color: Color(0xFF2E5A88), // Grey-blue
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  daysRemaining > 0
                      ? '$daysRemaining days left'
                      : 'Target date passed',
                  style: TextStyle(
                    color: daysRemaining > 0 
                        ? const Color(0xFF4A7C59) // Lighter jungle green for positive
                        : const Color(0xFFB00020), // Error red for negative
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}