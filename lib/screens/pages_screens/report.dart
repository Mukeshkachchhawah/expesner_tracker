
import 'package:flutter/material.dart';

class DataReportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;

  DataReportScreen(this.expenses);

  @override
  Widget build(BuildContext context) {
    double totalExpense = expenses.fold(
        0, (previousValue, element) => previousValue + element['amount']);

    return Scaffold(
      appBar: AppBar(title: Text("Report Expesne"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Expense Details:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${expenses[index]['category']}'),
                    subtitle: Text(
                      '\$${expenses[index]['amount'].toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


