import 'package:expense_tracker/provider/vm_categery.dart';
import 'package:expense_tracker/ui/pages_screens/categery_view_modal.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategryPage extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _CategryPageState();
}

class _CategryPageState extends ConsumerState<CategryPage> {
  @override
  Widget build(BuildContext context) {
    final categoryViewModel = ref.read(categoryVm);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense Category"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            hSpeace(),
            SizedBox(height: 20),
            InputTextFild(categoryViewModel),
            hSpeace(),
            ElevatedButton(
              onPressed: () {
                categoryViewModel.addCategory();
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  /// add new catgeory

  Widget InputTextFild(CategoryViewModal categoryViewModal) {
    return TextField(
      controller: categoryViewModal.categoryController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New Category',
          hintText: "Add New Category"),
    );
  }
}
