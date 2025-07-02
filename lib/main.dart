import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_expense_budget_tracker_for_students/providers/budget_provider.dart';
import 'package:smart_expense_budget_tracker_for_students/providers/expense_provider.dart';
import 'package:smart_expense_budget_tracker_for_students/providers/savings_goal_provider.dart';
import 'package:smart_expense_budget_tracker_for_students/screens/add_expense.dart';
import 'package:smart_expense_budget_tracker_for_students/screens/splash_screen.dart';
import 'package:smart_expense_budget_tracker_for_students/screens/home_screen.dart';
import 'package:smart_expense_budget_tracker_for_students/screens/budget_screen.dart';
import 'package:smart_expense_budget_tracker_for_students/screens/reports_screen.dart';
import 'package:smart_expense_budget_tracker_for_students/services/hive_service.dart';
import 'package:smart_expense_budget_tracker_for_students/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await HiveService.init(); // Initialize Hive database
    await NotificationService.init(); // Initialize notifications
    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization failed: $e'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) {
          final provider = ExpenseProvider();
          provider.loadExpenses();
          return provider;
        }),
        ChangeNotifierProvider(create: (_) => SavingsGoalProvider()..loadGoals()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()..loadBudget()),
      ],
      child: MaterialApp(
        title: 'Student Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFF2E5A88), // Grey-blue
            onPrimary: Colors.white,
            secondary: Color(0xFF1B4D3E), // Jungle green
            onSecondary: Colors.white,
            tertiary: Color(0xFF4A7C59), // Lighter jungle green
            onTertiary: Colors.white,
            error: Color(0xFFB00020),
            onError: Colors.white,
            background: Color(0xFFF5F7FA), // Light grey-blue background
            onBackground: Colors.black87,
            surface: Colors.white,
            onSurface: Colors.black87,
            surfaceVariant: Color(0xFFE8EDF2), // Light grey-blue surface
            onSurfaceVariant: Colors.black87,
            outline: Color(0xFF2E5A88),
            outlineVariant: Color(0xFFB8C5D1),
            shadow: Colors.black12,
            scrim: Colors.black26,
            inverseSurface: Colors.black87,
            onInverseSurface: Colors.white,
            inversePrimary: Color(0xFF4A7C59),
            surfaceTint: Color(0xFF2E5A88),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E5A88), // Grey-blue
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: Colors.black26,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          cardTheme: (
            color: Colors.white,
            elevation: 4,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF1B4D3E), // Jungle green
            foregroundColor: Colors.white,
            elevation: 6,
            shadowColor: Colors.black38,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E5A88), // Grey-blue
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2E5A88), // Grey-blue
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF5F7FA), // Light grey-blue
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB8C5D1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB8C5D1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E5A88), width: 2),
            ),
            labelStyle: const TextStyle(color: Colors.black87),
            hintStyle: const TextStyle(color: Colors.black54),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF2E5A88), // Grey-blue
            unselectedItemColor: Colors.black54,
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            shadowColor: Colors.black26,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black87,
            size: 24,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.black87),
            displayMedium: TextStyle(color: Colors.black87),
            displaySmall: TextStyle(color: Colors.black87),
            headlineLarge: TextStyle(color: Colors.black87),
            headlineMedium: TextStyle(color: Colors.black87),
            headlineSmall: TextStyle(color: Colors.black87),
            titleLarge: TextStyle(color: Colors.black87),
            titleMedium: TextStyle(color: Colors.black87),
            titleSmall: TextStyle(color: Colors.black87),
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black87),
            bodySmall: TextStyle(color: Colors.black54),
            labelLarge: TextStyle(color: Colors.black87),
            labelMedium: TextStyle(color: Colors.black87),
            labelSmall: TextStyle(color: Colors.black87),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (ctx) => const HomeScreen(),
          '/add-expense': (ctx) => const AddExpenseScreen(),
          '/budgets': (ctx) => const BudgetScreen(),
          '/reports': (ctx) => const ReportsScreen(),
        },
      ),
    );
  }
}