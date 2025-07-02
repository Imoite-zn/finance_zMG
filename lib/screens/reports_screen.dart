import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Reports')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics,
              size: 80,
              color: const Color(0xFF2E5A88).withOpacity(0.6), // Grey-blue with opacity
            ),
            const SizedBox(height: 20),
            Text(
              'Reports Coming Soon',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Detailed expense analytics and insights will be available here',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}