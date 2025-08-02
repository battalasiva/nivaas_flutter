import '../../../data/models/expenseSplitter/expense_splitter_details_model.dart';

abstract class ExpenseSplitterDetailsRepository {
  Future<ExpenseSplitterDetailsModel> getExpenseSplitterDetails(int splitterId);
}