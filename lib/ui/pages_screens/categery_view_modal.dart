import 'package:expense_tracker/repository/categery_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewModal extends ChangeNotifier {
  final CategoryRepository categoryRepository;
  CategoryViewModal({required this.categoryRepository}) {
    createTable();
  }

  TextEditingController categoryController = TextEditingController();

  ValueNotifier<List<Map<String, Object?>>> categoryNotifier =
      ValueNotifier([]);

// add Category
  void addCategory() {
    categoryRepository.addCategory(category: categoryController.text);
    fetchCategory();
  }

  fetchCategory() async {
    categoryNotifier.value = await categoryRepository.fetchCategory();
  }

  createTable() {
    categoryRepository.createTable().then((value) {
      if (value) {
        List<String> categories = [
          'Food',
          'Health insurance',
          'Emergency fund',
          'Patrol',
          'Shoping',
          'Travel',
          'Rent',
          'Other'
        ];
        //TODO: add default records
        for (var item in categories) {
          categoryRepository.addCategory(category: item);
        }
      }
    }).whenComplete(() {
      fetchCategory();
    });
  }
}
