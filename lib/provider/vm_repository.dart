import 'package:expense_tracker/repository/expense_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/categery_repository.dart';
import 'vm_databse.dart';

final expenseRepository = StateProvider((ref) => ExpenseRepository(ref.watch(databaseVm)),);


final categoryRepository = StateProvider((ref) => CategoryRepository(ref.watch(databaseVm)),);
