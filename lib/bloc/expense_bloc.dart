import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:expense_tracker/database/db_helper.dart';
import 'package:expense_tracker/modal/expesno_modal.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  AppDatabase db;
  ExpenseBloc({required this.db}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLodingState());
      var check = await db.addNewNote(event.newExpense);
      if (check) {
        var data = await db.getAllExpense();
        emit(ExpenseLoadedState(arrExpenses: data));
      } else {
        emit(ExpenseErroState(errorMsg: "Expense Not Added!!"));
      }
    });

    on<FatchAllExpenseEvent>((event, emit) async {
      emit(ExpenseLodingState());
      var data = await db.getAllExpense();
      emit(ExpenseLoadedState(arrExpenses: data));
    });
  }
}