abstract class ReportApi {
  createTable();
  addExpense(
      {required int amount,
      required int categoryId,
      required DateTime selectedDate,
      required int numberOfWeekSelected});
  fetchExpenseByMonth(String month);
  fetchMonthExpense();
  deleteExpense();
  updateExpense();
}
