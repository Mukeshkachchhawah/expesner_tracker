abstract class ReportApi {
  createTable();
  addExpense({
    required int amount,
    required int categoryId,
    required DateTime selectedDate,
    required int numberOfWeekSelected,
    required int year,
  });
  fetchExpenseByMonth(String month);
  fetchMonthListExpense(int year);
  deleteExpense();
  updateExpense();
}
