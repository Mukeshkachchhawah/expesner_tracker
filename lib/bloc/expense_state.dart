part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  // Check Database folder
//// check getAllData fache ListTpes
  List<ExpenseModal> arrExpenses;
  ExpenseLoadedState({required this.arrExpenses});
}

class ExpenseErrorState extends ExpenseState {
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}
