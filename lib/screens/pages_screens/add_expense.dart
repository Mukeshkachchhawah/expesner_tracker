import 'package:expense_tracker/modal/category_list.dart';
import 'package:expense_tracker/screens/onbording%20screens/bottomBar_screens.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final Function(String, double) addExpense;
  String selectedCategory;

  AddExpenseScreen(this.addExpense, this.selectedCategory);

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  double amount = 0.0;
  String category = '';

  /// clear inpute TextFild amount and clear category
  void clearFields() {
    setState(() {
      amount = 0.0;
      category = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expesne"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AmountTextFild(),
              hSpeace(),
              Text(
                'Selected Category: $category',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        category = categories[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: category == categories[index]
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(categories[index]),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
              hSpeace(),
              ElevatedButton(
                onPressed: () {
                  if (amount > 0 && category.isNotEmpty) {
                    widget.addExpense(category, amount);
                    // clear textfild and catgory
                    clearFields();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Expense added successfully'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter valid category and amount'),
                      ),
                    );
                  }
                },
                child: Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget AmountTextFild() {
    return

        /// input textform field
        TextFormField(
      style: textStyle80(),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          amount = double.tryParse(value) ?? 0.0;
        });
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: textStyle80(),
        hintText: '₹ 0000',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
