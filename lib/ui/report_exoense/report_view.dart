// ignore_for_file: must_be_immutable, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:expense_tracker/modal/week_wish_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../provider/vm_provider.dart';

class ReportView extends ConsumerStatefulWidget {
  final String monthName;
  ReportView({super.key, required this.monthName});

  String? dropdownValue;

  @override
  ConsumerState<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends ConsumerState<ReportView> {
  // List<FilterExpensceModalMonthWise> filterMonthExpense = [];
  // List<WeekWiseExpenses> weekWiseExpenses = [];
  // double totalExpense = 0.0;
  // double totalMonthExpense = 0.0;

  @override
  void initState() {
    super.initState();
    calculateWeekWiseExpenses();
    calculateTotalExpense();
  }

  @override
  Widget build(BuildContext context) {
    //     .fold(0, (previousValue, element) => previousValue + element['amount']);
    final provider = ref.watch(reportVm);
    provider.fetchReport(widget.monthName);
    return Scaffold(
        appBar: AppBar(
          title: Text("Report Expense : ${widget.monthName}"),
          actions: [
            DropdownButton(
              items: [],
              onChanged: (value) {},
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: provider.allReport,
          builder: (context, list, child) {
            return GroupedListView<dynamic, int>(
              elements: list,
              groupBy: (element) => element['number_of_week'],
              groupSeparatorBuilder: (int groupByValue) =>
                  Text("Week $groupByValue"),
              itemBuilder: (context, dynamic element) {
                print('expense data ${element}');
                return ListTile(
                  title: Text('${element['categoryName']}'),
                  trailing: Column(
                    children: [
                      Text(DateFormat('dd MMMM yyyy')
                          .format(DateTime.fromMillisecondsSinceEpoch(
                              element['date']))
                          .toString()),
                      Text(element['exp_amt'].toString()),
                    ],
                  ),
                );
              },
              //  itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.ASC, // optional
            );
          },
        )

        // ListView.builder(
        //   itemCount: reportList.length,
        //   itemBuilder: (context, index) {
        //     final reportItem = reportList[index];
        //     final weekList = reportItem.weekList ?? [];
        //     return ExpansionTile(
        //       title: Text(
        //         reportItem.monthName ?? 'Na',
        //         style:
        //             const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Text(''),
        //       trailing: Text(
        //         'Total: \₹ ${reportItem.totalExpense}',
        //         style:
        //             const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        //       ),
        //       children: [
        //         for (var week in weekList)
        //           ListTile(
        //             onTap: () {
        //               showModalBottomSheet(
        //                 showDragHandle: true,
        //                 isScrollControlled: true,
        //                 context: context,
        //                 builder: (context) {
        //                   return const DaysListExpenseView();
        //                 },
        //               );
        //             },
        //             title: Text(week.weekName ?? ''),
        //           ),
        //       ],
        //     );
        //   },
        // ),

        );
  }

/*   Widget example() {
    return DropdownButton<String>(
      value: dropdownValue,
      hint: Text('Select a color'),
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Red', 'Green', 'Blue']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
 */
  /// week wish amount
  List<WeekWiseExpenses> calculateWeekWiseExpenses() {
    try {
      // if (widget.expenses == null || widget.expenses.isEmpty) {
      //   return [];
      // }

      // List<Expense> weeklyExpenses = widget.expenses
      //     .map((expense) => Expense(
      //           amount: expense['amount'],
      //           date: DateTime.parse(expense['date']),
      //         ))
      //     .toList();

      // weeklyExpenses.sort((a, b) => a.date.compareTo(b.date));

      List<WeekWiseExpenses> result = [];

      return result;
    } catch (e, stackTrace) {
      print('Error in calculateWeekWiseExpenses: $e');
      print('Stack Trace: $stackTrace');
      return [];
    }
  }

  void calculateTotalExpense() {
    // setState(() {
    //   totalExpense = widget.expenses.fold(
    //       0, (previousValue, element) => previousValue + element['amount']);
    // });
  }

  /// show bottom sheet

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // child: _buildCustomBottomSheetContent(),
          ),
        );
      },
    );
  }

  // Widget _buildCustomBottomSheetContent() {
  //   return Container(
  //     height: 600,
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Text(
  //           ' Expenses',
  //           style: TextStyle(
  //             fontSize: 20.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: expenses.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 title: Text('${expenses[index]['category']}'),
  //                 subtitle: Text(
  //                   '\₹${expenses[index]['amount'].toStringAsFixed(2)}',
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Close'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
