// ignore_for_file: must_be_immutable, avoid_print, unused_element

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
              useStickyGroupSeparators: true, // optional
              floatingHeader: true, // optional
              order: GroupedListOrder.ASC, // optional
            );
          },
        ));
  }
}
