import 'package:nivaas/data/repository-impl/expenseSplitter/expense_splitter_details_repositoryimpl.dart';

import '../../../data/models/expenseSplitter/expense_splitter_details_model.dart';

class ExpenseSplitterDetailsUsecase {
  final ExpenseSplitterDetailsRepositoryimpl repository;

  ExpenseSplitterDetailsUsecase({required this.repository});

  Future<ExpenseSplitterDetailsModel> getDetails(int splitterId){
    return repository.getExpenseSplitterDetails(splitterId);
  }
}