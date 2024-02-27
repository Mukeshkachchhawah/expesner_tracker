import 'package:expense_tracker/network/api/report_api.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepository implements ReportApi {
  Database database;
  ExpenseRepository(this.database);

  static const tableName = "dbReportNewone";
//var USER_COLUMN_ID = "uid";
  // static const expId = "exp_id";

  static const amountColumn = "exp_amt";

  static const categoryIdColumn = "exp_cat_id";
  static const monthColumn = "month_group_name";
  static const dateColumn = "date";
  static const numberOfWeekColumn = "number_of_week";

  @override
  addExpense({
    required int amount,
    required int categoryId,
    required int numberOfWeekSelected,
    required DateTime selectedDate,
  }) async {
    // Format the month name using intl package
    String monthName = DateFormat('MMMM').format(selectedDate);
    var status = await database.insert(tableName, {
      amountColumn: amount,
      categoryIdColumn: categoryId,
      dateColumn: selectedDate.millisecondsSinceEpoch,
      monthColumn: monthName,
      numberOfWeekColumn: numberOfWeekSelected
    });
    print("QUERY EXECUTE STATUS $status");
  }

  @override
  createTable() async {
    if (!(database.isOpen)) {
      print('DATABASE NOT OPEN');
      return;
    }

    print('DATABASE IS OPEN');
    const quary = 'CREATE TABLE $tableName '
        '(id INTEGER PRIMARY KEY '
        'AUTOINCREMENT,'
        ' $amountColumn int,'
        ' $categoryIdColumn TEXT,'
        ' $dateColumn int,'
        ' $numberOfWeekColumn int,'
        ' $monthColumn TEXT'
        ')';
    print("Quary ==> $quary");

    try {
      await database.execute(quary);

      print('TABLE SUCCESSFULLY CREATED');
    } catch (e) {}
  }

  @override
  deleteExpense() {
    // TODO: implement deleteExpense
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, Object?>>> fetchExpenseByMonth(String month) async {
    return await database
        .query(tableName, where: '$monthColumn =?', whereArgs: [month]);
  }

  @override
  Future<List<Map<String, Object?>>> fetchMonthExpense() async {
    // Use the strftime function to extract the month from the date column
    List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT DISTINCT $monthColumn FROM $tableName',
    );

    // Extract the month values from the result
    // List<String> months =
    //     result.map((row) => row['month_group_name'].toString()).toList();

    return result;
  }

  @override
  updateExpense() {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }
}
