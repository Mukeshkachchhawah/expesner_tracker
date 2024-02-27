part of 'expense_bloc.dart';

@immutable
class ExpenseEvent {}

/// add expense
class AddExpenseEvent extends ExpenseEvent {
/*   final String category;
  final double amount; */
  ExpenseModal newExpense;

  AddExpenseEvent({
    required this.newExpense,
  });
}

/// fatchallExpense
class FetchAllExpenseEvent extends ExpenseEvent {}
