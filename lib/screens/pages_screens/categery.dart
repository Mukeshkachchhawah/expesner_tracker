import 'package:expense_tracker/modal/category_list.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';

class CategryPage extends StatefulWidget {
  @override
  _CategryPageState createState() => _CategryPageState();
}

class _CategryPageState extends State<CategryPage> {
  TextEditingController categoryController = TextEditingController();
  // List<String> categories = ['Category 1', 'Category 2', 'Category 3', 'Category 4', 'Category 5', 'Category 6', 'Category 7', 'Category 8'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense Category"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// add this page catgory list
            /// no use code
            /*  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Handle category selection
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          categories[index],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ), */
            hSpeace(),
            TextField(
              controller: categoryController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Category',
                  hintText: "Add New Category"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addCategory();
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  /// add new catgeory

  void addCategory() {
    String newCategory = categoryController.text.trim();
    if (newCategory.isNotEmpty && !categories.contains(newCategory)) {
      setState(() {
        categories.add(newCategory);
      });
      categoryController.clear();
    }
  }
}
