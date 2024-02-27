import 'package:expense_tracker/provider/vm_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/report_exoense/report_view_model.dart';

final reportVm = StateProvider((ref) => ExpenseViewModel(ref.watch(expenseRepository)));
