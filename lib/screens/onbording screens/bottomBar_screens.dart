import 'package:expense_tracker/bloc/expense_bloc.dart';
import 'package:expense_tracker/screens/pages_screens/add_expense.dart';
import 'package:expense_tracker/screens/pages_screens/categery.dart';
import 'package:expense_tracker/screens/pages_screens/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  int _currentIndex = 1;
  List<Map<String, dynamic>> expenses = [];
  String selectedCategory = '';

  void addExpense(String category, double amount) {
    setState(() {
      expenses.add({
        'category': category,
        'amount': amount,
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: [
              CategryPage(),
             
              AddExpenseScreen(addExpense, selectedCategory),
          DataReportScreen(expenses),
          
           
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
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
      },
    );
  }
}
