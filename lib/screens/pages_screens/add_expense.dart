import 'package:expense_tracker/modal/category_list.dart';
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
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void clearFields() {
    setState(() {
      amount = 0.0;
      category = '';
      categoryController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AmountTextField(),
            hSpeace(mHeight: 50),

            /// girdview.builder
            ItemGridView(),
            hSpeace(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (amount > 0 && category.isNotEmpty) {
                    widget.addExpense(category, amount);

                    clearFields();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Expense added successfully'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please enter a valid category and amount'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Add Expense',
                  style: textStyle16(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ItemGridView() {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 12 / 16,
        ),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
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
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      category == categories[index] ? Colors.blue : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget AmountTextField() {
    return TextFormField(
      style: textStyle90(),
      keyboardType: TextInputType.number,
      controller: amountController,
      onChanged: (value) {
        setState(() {
          amount = double.tryParse(value) ?? 0.0;
        });
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: textStyle90(),
        hintText: '₹ 0000',
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
