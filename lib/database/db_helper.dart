import 'package:expense_tracker/modal/expesno_modal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class AppDatabase {
  AppDatabase._();

  static const EXPENSE_TABLE = "expense";
//var USER_COLUMN_ID = "uid";
  static const EXPENSE_COLUMN_ID = "exp_id";

  static const EXPENSE_COLUMN_AMT = "exp_amt";

  static const EXPENSE_COLUMN_CAT_ID = "exp_cat_id";

  static Database? database;
  static Future<void> openDB() async {
    //directory path
    var mDirectory = await getApplicationDocumentsDirectory();

    //created the path
    await mDirectory.create(recursive: true);

    var dbPath = "$mDirectory/mainDB.db";

    var databaseTemp =
        await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      var expenseTableQuery =
          "create table $EXPENSE_TABLE ( $EXPENSE_COLUMN_ID integer primary key autoincrement, $EXPENSE_COLUMN_AMT real, $EXPENSE_COLUMN_CAT_ID integer)";

      // "create table $EXPENSE_TABLE ( $EXPENSE_COLUM_ID integer primary key autoincrement, $USER_COLUMN_ID integer, $EXPENSE_COLUM_TITLE text, $EXPENSE_COLUM_DESC text, $EXPENSE_COLUM_AMOUNT real, $EXPENSE_COLUM_BALENCE real, $EXPENSE_COLUM_TYPE integer, $EXPENSE_COLUM_CATGERY_ID integer, $EXPENSE_COLUM_CATGERY_DATE text)";

      db.execute(expenseTableQuery);
    }).then((db) {
      print("DATABASE CREATE SUCCESSFULLY");
      database = db;
    });
  }

  static Database getDataBase() {
    return database!;
  }

  //// function in Expense App /////
  ///add New Expense

  // Future<bool> addNewNote(ExpenseModal newExpense) async {
  //   var check = await db.insert(EXPENSE_TABLE, newExpense.toMap());

  //   return check > 0;
  // }

  // Future<List<ExpenseModal>> getAllExpense() async {
  //   List<Map<String, dynamic>> expense = await db.query(EXPENSE_TABLE);

  //   List<ExpenseModal> arrExpense = [];

  //   for (Map<String, dynamic> eachExpense in expense) {
  //     var eacModal = ExpenseModal.fromMap(eachExpense);
  //     arrExpense.add(eacModal);
  //   }
  //   return arrExpense;
  // }
}

//// Expence Funtion
