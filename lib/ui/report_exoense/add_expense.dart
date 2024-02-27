// ignore_for_file: non_constant_identifier_names
import 'package:expense_tracker/provider/vm_categery.dart';
import 'package:expense_tracker/provider/vm_provider.dart';
import 'package:expense_tracker/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'report_view_model.dart';

// ignore: must_be_immutable
class AddExpenseScreen extends ConsumerStatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AddExpenseScreen();
  @override
  // ignore: library_private_types_in_public_api
  ConsumerState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    final providerVm = ref.watch(reportVm);
    providerVm.updateDate(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            amountTextField(providerVm),
            hSpeace(mHeight: 50),

            /// gride.builder
            ItemGridView(providerVm),
            hSpeace(),
            ValueListenableBuilder(
              valueListenable: providerVm.selectedDate,
              builder: (context, date, child) {
                return OutlinedButton(
                    onPressed: () async {
                      var date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate: DateTime(2050),
                          initialDate: DateTime.now());

                      if (date == null) {
                        return;
                      }
                      providerVm.updateDate(date);
                    },
                    child: Text("${date.toString()} : Change date"));
              },
            ),
            hSpeace(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // if (amount > 0 && category.isNotEmpty) {
                  providerVm.addNewExpense();
                  // widget.addExpense(category, amount);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Expense added successfully'),
                    ),
                  );
                }
                // else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content:
                //           Text('Please enter a valid category and amount'),
                //     ),
                //   );
                // }
                // },
                ,
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

  Widget ItemGridView(ExpenseViewModel expenseViewModel) {
    final categoryProvider = ref.watch(categoryVm);

    return ValueListenableBuilder(
      valueListenable: categoryProvider.categoryNotifier,
      builder: (context, list, child) {
        return list.isEmpty
            ? Text('No category found')
            : SizedBox(
                height: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 12 / 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // setState(() {
                        expenseViewModel.selectCategory(
                            int.parse((list[index]['id'] ?? -1).toString()));
                        // });
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (list[index]['categoryName']).toString(),
                              style: const TextStyle(
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
      },
    );
  }

  Widget amountTextField(ExpenseViewModel reportViewModel) {
    return TextFormField(
      style: textStyle90(),
      keyboardType: TextInputType.number,
      controller: reportViewModel.amountController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: textStyle90(),
        hintText: '₹ 0000',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
