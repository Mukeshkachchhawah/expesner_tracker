// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, empty_catches

import 'package:expense_tracker/network/api/report_api.dart';
import 'package:expense_tracker/repository/categery_repository.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepository implements ReportApi {
  Database database;
  ExpenseRepository(this.database);

  static const tableName = "dbReportNewFoure";

  static const amountColumn = "exp_amt";

  static const categoryIdColumn = "exp_cat_id";
  static const monthColumn = "month_group_name";
  static const dateColumn = "date";
  static const numberOfWeekColumn = "number_of_week";
  static const yearColumn = "year";

  @override
  addExpense({
    required int amount,
    required int categoryId,
    required int numberOfWeekSelected,
    required int year,
    required DateTime selectedDate,
  }) async {
    // Format the month name using intl package
    String monthName = DateFormat('MMMM yyyy').format(selectedDate);
    var status = await database.insert(tableName, {
      amountColumn: amount,
      categoryIdColumn: categoryId,
      dateColumn: selectedDate.millisecondsSinceEpoch,
      monthColumn: monthName,
      numberOfWeekColumn: numberOfWeekSelected,
      yearColumn: year
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
        ' $monthColumn TEXT,'
        ' $yearColumn int'
        ')';
    print("Quary ==> $quary");

    try {
      await database.execute(quary);

      print('TABLE SUCCESSFULLY CREATED');
    } catch (e) {}
  }

  @override
  deleteExpense() {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, Object?>>> fetchExpenseByMonth(String month) async {
    var res = await database.rawQuery('''
    SELECT reports.*,
           categories.*
    FROM ${tableName} AS reports
    INNER JOIN ${CategoryRepository.tableName} AS categories ON reports.${categoryIdColumn} = categories.id WHERE reports.${monthColumn} = ? ORDER BY reports.${dateColumn}''',
        [month]);
    return res;
  }

  @override
  Future<List<Map<String, Object?>>> fetchMonthListExpense(int year) async {
    // Use the strftime function to extract the month from the date column
    // List<Map<String, dynamic>> result = await database.rawQuery('''
    //   SELECT *, SUM(${amountColumn}) as totalAmount
    //   FROM $tableName
    //   GROUP BY ${monthColumn} ORDER BY $dateColumn
    // ''');

    List<Map<String, dynamic>> result = await database.rawQuery('''
      SELECT *, SUM(${amountColumn}) as totalAmount
      FROM $tableName WHERE $yearColumn = ?
      GROUP BY ${monthColumn} ORDER BY $dateColumn
    ''', [year]);

    print('MONTH REPORT ${result}');
    return result;
  }

  @override
  updateExpense() {
    throw UnimplementedError();
  }
}
