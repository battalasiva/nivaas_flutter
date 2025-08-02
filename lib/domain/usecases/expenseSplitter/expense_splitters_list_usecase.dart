import 'package:nivaas/data/repository-impl/expenseSplitter/expense_splitters_list_repositoryimpl.dart';

import '../../../data/models/expenseSplitter/expense_splitters_list_model.dart';

class ExpenseSplittersListUsecase {
  final ExpenseSplittersListRepositoryimpl repository;

  ExpenseSplittersListUsecase({required this.repository});

  Future<List<ExpenseSplittersListModel>> call(int apartmentId){
    return repository.fetchExpenseSplittersList(apartmentId);
  }

  Future<ExpenseSplittersListModel> executeEnable(int splitterId, bool isEnabled){
    return repository.enableExpenseSplitter(splitterId, isEnabled);
  }
}