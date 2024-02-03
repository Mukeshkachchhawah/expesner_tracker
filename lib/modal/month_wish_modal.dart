import 'expesno_modal.dart';

class MonthWishModal {
  String january;
  String february;
  String march;
  String april;
  String may;
  String june;
  String july;
  String august;
  String september;
  String october;
  String november;
  String december;

  MonthWishModal(
      {required this.january,
      required this.february,
      required this.march,
      required this.april,
      required this.may,
      required this.june,
      required this.july,
      required this.august,
      required this.september,
      required this.october,
      required this.november,
      required this.december});
}

///////// Filter Expensce weekly /////////////
class FilterExpensceModal {
  String date;
  String amount;
  List<ExpenseModal> arrExpenseModal;

  FilterExpensceModal(
      {required this.date,
      required this.amount,
      required this.arrExpenseModal});
}

///////// Filter Expensce Month wish /////////////

class FilterExpensceModalMonthWise {
  String Month;
  String amount;
  List<ExpenseModal> arrExpenseModal;

  FilterExpensceModalMonthWise(
      {required this.Month,
      required this.amount,
      required this.arrExpenseModal});
}
