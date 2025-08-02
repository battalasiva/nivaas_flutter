import 'package:nivaas/data/models/expenseSplitter/add_expense_splitter_model.dart';

abstract class AddExpenseSplitterRepository {
  Future<bool> createExpenseSplitter(AddExpenseSplitterModel splitDetails,);
}