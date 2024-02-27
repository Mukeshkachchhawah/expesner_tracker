import 'package:expense_tracker/network/api/categery_api.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository implements CategoryApi {
  final Database database;
  CategoryRepository(this.database);

  static const tableName = "dbCategoryNew";
  static const categoryName = "categoryName";

  @override
  addCategory({required String category}) async {
    var status = await database.insert(tableName, {
      categoryName: category,
    });

    print('Add category status : $status');
  }

  @override
  Future<bool> createTable() async {
    if (!(database.isOpen)) {
      print('DATABASE NOT OPEN');
      return false;
    }

    print('DATABASE IS OPEN');
    try {
      await database.execute('CREATE TABLE $tableName '
          '(id INTEGER PRIMARY KEY '
          'AUTOINCREMENT,'
          ' $categoryName TEXT'
          ')');

      print('TABLE SUCCESSFULLY CREATED');
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  deleteCategory() {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }


    @override
  Future<List<Map<String, Object?>>> fetchCategory() async {
    return await database.query(
      tableName,
    );
  }

  @override
  updateCategory() {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
