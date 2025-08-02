import 'package:nivaas/data/models/expenseSplitter/add_expense_splitter_model.dart';
import 'package:nivaas/data/provider/network/api/expenseSplitter/add_expense_splitter_datasource.dart';
import 'package:nivaas/domain/repositories/expenseSplitter/add_expense_splitter_repository.dart';

class AddExpenseSplitterRepositoryimpl implements AddExpenseSplitterRepository {
  final AddExpenseSplitterDatasource datasource;

  AddExpenseSplitterRepositoryimpl({required this.datasource});
  @override
  Future<bool> createExpenseSplitter(AddExpenseSplitterModel splitDetails) {
    return datasource.createExpenseSplitter(splitDetails);
  }
  
}