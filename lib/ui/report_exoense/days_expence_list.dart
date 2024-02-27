import 'package:expense_tracker/provider/vm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DaysListExpenseView extends ConsumerWidget {
  const DaysListExpenseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(reportVm);
    // provider.fetchReport();
    return ValueListenableBuilder(
        valueListenable: provider.allReport,
        builder: (context, list, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var reportItem = list[index];

                print('item $reportItem');
                int date = reportItem['date'] as int;
                return ListTile(
                  title: Text(reportItem['month_group_name'].toString()),
                  subtitle: Text('${reportItem['exp_cat_id']}'),
                  trailing: Text(reportItem['exp_amt'].toString()),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: list.length);
        });
  }
}
