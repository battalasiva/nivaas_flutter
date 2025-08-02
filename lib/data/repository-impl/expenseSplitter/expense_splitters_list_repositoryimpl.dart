import 'package:nivaas/data/models/expenseSplitter/expense_splitters_list_model.dart';
import 'package:nivaas/data/provider/network/api/expenseSplitter/expense_splitters_list_datasource.dart';
import 'package:nivaas/domain/repositories/expenseSplitter/expense_splitters_list_repository.dart';

class ExpenseSplittersListRepositoryimpl implements ExpenseSplittersListRepository {
  final ExpenseSplittersListDatasource datasource;

  ExpenseSplittersListRepositoryimpl({required this.datasource});
  @override
  Future<List<ExpenseSplittersListModel>> fetchExpenseSplittersList(int apartmentId) {
    return datasource.fetchExpenseSplittersList(apartmentId);
  }
  
  @override
  Future<ExpenseSplittersListModel> enableExpenseSplitter(int splitterId, bool isEnabled) {
    return datasource.enableExpenseSplitter(splitterId, isEnabled);
  }
  
}