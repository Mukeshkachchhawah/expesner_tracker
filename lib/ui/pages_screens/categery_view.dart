import 'package:expense_tracker/provider/vm_categery.dart';
import 'package:expense_tracker/ui/pages_screens/categery_view_modal.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final categoryViewModel = ref.read(categoryVm);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            hSpeace(),
            const SizedBox(height: 20),
            inputTextFile(categoryViewModel),
            hSpeace(),
            ElevatedButton(
              onPressed: () {
                categoryViewModel.addCategory();
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  /// add new category

  Widget inputTextFile(CategoryViewModal categoryViewModal) {
    return TextField(
      controller: categoryViewModal.categoryController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New Category',
          hintText: "Add New Category"),
    );
  }
}
