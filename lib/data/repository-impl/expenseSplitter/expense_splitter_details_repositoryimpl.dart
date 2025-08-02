import 'package:nivaas/data/models/expenseSplitter/expense_splitter_details_model.dart';
import 'package:nivaas/data/provider/network/api/expenseSplitter/expense_splitter_details_datasource.dart';
import 'package:nivaas/domain/repositories/expenseSplitter/expense_splitter_details_repository.dart';

class ExpenseSplitterDetailsRepositoryimpl implements ExpenseSplitterDetailsRepository {
  final ExpenseSplitterDetailsDatasource datasource;

  ExpenseSplitterDetailsRepositoryimpl({required this.datasource});
  @override
  Future<ExpenseSplitterDetailsModel> getExpenseSplitterDetails(int splitterId) {
    return datasource.getExpenseSplitterDetails(splitterId);
  }
  
}