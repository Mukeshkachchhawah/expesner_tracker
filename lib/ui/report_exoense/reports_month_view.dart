// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/vm_provider.dart';
import 'report_view.dart';
import 'report_view_model.dart';

class ReportsMonthView extends ConsumerStatefulWidget {
  ReportsMonthView();

  String? dropdownValue;

  @override
  ConsumerState<ReportsMonthView> createState() => _ReportsMonthViewState();
}

class _ReportsMonthViewState extends ConsumerState<ReportsMonthView> {
  late ExpenseViewModel provider;
  @override
  void initState() {
    provider = ref.read(reportVm);
    provider.fetchMonthList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider.fetchMonthList();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Report Expense"),
        ),
        body: ValueListenableBuilder(
          valueListenable: provider.monthList,
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final reportItem = value[index];
                final monthYear = reportItem['month_group_name'].toString();
                print('reort ${reportItem}');
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportView(
                              monthName:
                                  (reportItem['month_group_name'].toString())),
                        ));
                  },
                  title: Text(
                    '${monthYear.split(' ').first}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(''),
                  trailing: Text(
                    'Total: \₹ ${reportItem['totalAmount']}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          },
        ));
  }
}
