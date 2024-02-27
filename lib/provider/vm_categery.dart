import 'package:expense_tracker/provider/vm_repository.dart';
import 'package:expense_tracker/repository/categery_repository.dart';
import 'package:expense_tracker/ui/pages_screens/categery_view_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryVm = StateProvider((ref) => CategoryViewModal(categoryRepository: ref.watch(categoryRepository)));
