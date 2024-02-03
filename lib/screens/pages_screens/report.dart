import 'package:flutter/material.dart';
import 'package:expense_tracker/modal/month_wish_modal.dart';
import 'package:expense_tracker/modal/week_wish_modal.dart';
import 'package:intl/intl.dart';

class DataReportScreen extends StatefulWidget {
  final List<Map<String, dynamic>> expenses;

  DataReportScreen(this.expenses);

  @override
  State<DataReportScreen> createState() => _DataReportScreenState();
}

class _DataReportScreenState extends State<DataReportScreen> {
  List<FilterExpensceModalMonthWise> filterMonthExpense = [];
  List<WeekWiseExpenses> weekWiseExpenses = [];
  double totalExpense = 0.0;
  double totalMonthExpense = 0.0;

  @override
  void initState() {
    super.initState();
    calculateWeekWiseExpenses();
    calculateTotalExpense();
  }

  @override
  Widget build(BuildContext context) {
    /// totalExpense month amount
    double totalExpense = widget.expenses
        .fold(0, (previousValue, element) => previousValue + element['amount']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _showCustomBottomSheet(context);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  /// curent  month number and year
                  /// 02 2024
                  // "${DateTime.now().month} ${DateTime.now().year}",

                  /// curent monut name and yeat
                  /// February 2024
                  DateFormat('MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  'Total: \₹ ${totalExpense.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            /// not working 
            /// panding this code chack code
             Expanded(
              child: ListView.builder(
                itemCount: weekWiseExpenses.length,
                itemBuilder: (context, index) {
                  WeekWiseExpenses weekExpenses = weekWiseExpenses[index];
                  return ListTile(
                    title: Text(
                      'Week ${index + 1}: ${weekExpenses.weekStartDate.toLocal()} - ${weekExpenses.weekEndDate.toLocal()}',
                    ),
                    subtitle: Text(
                        'Total Expense: \₹${weekExpenses.totalExpense.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// week wish amount
  List<WeekWiseExpenses> calculateWeekWiseExpenses() {
    try {
      if (widget.expenses == null || widget.expenses.isEmpty) {
        return [];
      }

      List<Expense> weeklyExpenses = widget.expenses
          .map((expense) => Expense(
                amount: expense['amount'],
                date: DateTime.parse(expense['date']),
              ))
          .toList();

      weeklyExpenses.sort((a, b) => a.date.compareTo(b.date));

      List<WeekWiseExpenses> result = [];
      DateTime currentWeekStart = weeklyExpenses.first.date;
      double currentWeekTotal = 0;

      for (Expense expense in weeklyExpenses) {
        if (expense.date.difference(currentWeekStart).inDays >= 7) {
          result.add(WeekWiseExpenses(
            weekStartDate: currentWeekStart,
            weekEndDate: currentWeekStart.add(Duration(days: 6)),
            totalExpense: currentWeekTotal,
          ));
          currentWeekStart = expense.date;
          currentWeekTotal = 0;
        }

        currentWeekTotal += expense.amount;
      }

      result.add(WeekWiseExpenses(
        weekStartDate: currentWeekStart,
        weekEndDate: currentWeekStart.add(Duration(days: 6)),
        totalExpense: currentWeekTotal,
      ));

      setState(() {
        weekWiseExpenses = result;
      });

      return result;
    } catch (e, stackTrace) {
      print('Error in calculateWeekWiseExpenses: $e');
      print('Stack Trace: $stackTrace');
      return [];
    }
  }

  void calculateTotalExpense() {
    setState(() {
      totalExpense = widget.expenses.fold(
          0, (previousValue, element) => previousValue + element['amount']);
    });
  }

  /// show bottom sheet

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: _buildCustomBottomSheetContent(widget.expenses),
          ),
        );
      },
    );
  }

  Widget _buildCustomBottomSheetContent(List<Map<String, dynamic>> expenses) {
    return Container(
      height: 600,
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ' Expenses',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${expenses[index]['category']}'),
                  subtitle: Text(
                    '\₹${expenses[index]['amount'].toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
