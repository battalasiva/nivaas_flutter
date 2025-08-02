import '../../../data/models/expenseSplitter/expense_splitters_list_model.dart';

abstract class ExpenseSplittersListRepository {
  Future<List<ExpenseSplittersListModel>> fetchExpenseSplittersList(int apartmentId);
  Future<ExpenseSplittersListModel> enableExpenseSplitter(int splitterId, bool isEnabled);
}