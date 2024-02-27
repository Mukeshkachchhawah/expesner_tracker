import 'package:expense_tracker/models/report/report_week_model.dart';
import 'package:expense_tracker/ui/report_exoense/days_expence_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/modal/month_wish_modal.dart';
import 'package:expense_tracker/modal/week_wish_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../models/report/report_days_model.dart';
import '../../models/report/report_model.dart';
import '../../provider/vm_provider.dart';
import 'report_view.dart';

class ReportsMonthView extends ConsumerStatefulWidget {
  ReportsMonthView();

  String? dropdownValue;

  @override
  ConsumerState<ReportsMonthView> createState() => _ReportsMonthViewState();
}

class _ReportsMonthViewState extends ConsumerState<ReportsMonthView> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(reportVm);
    provider.fetchMonthsReport();
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
                    '${reportItem['month_group_name']}',
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(''),
                  trailing: Text(
                    'Total: \₹ ${'1234'}',
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
