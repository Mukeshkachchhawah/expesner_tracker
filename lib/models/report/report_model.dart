import 'report_week_model.dart';

class ReportModel {
  String? monthName;
  String? totalExpense;
  List<ReportWeekModel>? weekList;
  ReportModel({this.monthName, this.totalExpense, this.weekList});
}
