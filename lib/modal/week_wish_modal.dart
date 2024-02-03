class Expense {
  final double amount;
  final DateTime date;

  Expense({required this.amount, required this.date});
}

class WeekWiseExpenses {
  final DateTime weekStartDate;
  final DateTime weekEndDate;
  final double totalExpense;

  WeekWiseExpenses({
    required this.weekStartDate,
    required this.weekEndDate,
    required this.totalExpense,
  });
}
