// ignore_for_file: library_private_types_in_public_api

import 'package:expense_tracker/ui/report_exoense/add_expense.dart';
import 'package:expense_tracker/ui/pages_screens/categery_view.dart';
import 'package:flutter/material.dart';

import '../report_exoense/reports_month_view.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  int _currentIndex = 1;
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          CategoryPage(),
          const AddExpenseScreen(),
          ReportsMonthView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Add Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Expense Report',
          ),
        ],
      ),
    );
  }
}
