import 'package:flutter/material.dart';

import '../../repository/expense_repository.dart';

class ExpenseViewModel extends ChangeNotifier {
  ExpenseRepository expenseRepository;
  ExpenseViewModel(this.expenseRepository) {
    createTable();
  }
  double amount = 0.0;
  int category = -1;
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  ValueNotifier<List<Map<String, Object?>>> allReport = ValueNotifier([]);
  ValueNotifier<List<Map<String, Object?>>> monthList = ValueNotifier([]);

  ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);
  void clearFields() {
    amount = 0.0;
    category = -1;
    categoryController.clear();
    amountController.clear();
  }

  addNewExpense() {
    // check validate

    if (category == -1) {
      //Error : Select category first
      print('Select Category first');
      return;
    } else if (selectedDate.value == null) {
      print('Select Date first');
      return;
    }

    int weekNum = getWeekNumberOfMonth(selectedDate.value!);

    print('Select week number is $weekNum of month');
    expenseRepository.addExpense(
        amount: int.parse(amountController.text),
        categoryId: category,
        selectedDate: selectedDate.value!,
        numberOfWeekSelected: weekNum,
        year: selectedDate.value?.year ?? 0);
    clearFields();
  }

  createTable() {
    expenseRepository.createTable();
  }

  fetchReport(String month) {
    expenseRepository.fetchExpenseByMonth(month).then((value) {
      print('TOTAL REPORT FETCH ${allReport.value.length}');
      allReport.value = value;
    });
  }

  fetchMonthList() {
    expenseRepository.fetchMonthListExpense(2024).then((value) {
      // print('TOTAL REPORT FETCH monthList ${monthList.value.length}');
      monthList.value = value;
    });
  }

  void selectCategory(int id) {
    category = id;

    print('Category Selected $category');
  }

  void updateDate(DateTime date) {
    selectedDate.value = date;
    int weekNum = getWeekNumberOfMonth(date);

    print('Select num of week $weekNum');
  }


/// Week Wish Month 
  int getWeekNumberOfMonth(DateTime date) {
    // Use the first day of the month and the day of the week to calculate the week number
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int dayOfWeek = firstDayOfMonth.weekday;
    int daysInFirstWeek = 7 - (dayOfWeek - 1);

    int dayOfYear = date.difference(firstDayOfMonth).inDays + 1;

    if (dayOfYear <= daysInFirstWeek) {
      return 1;
    } else {
      return ((dayOfYear - daysInFirstWeek) / 7).ceil() + 1;
    }
  }
}
