import 'package:nivaas/data/models/expenseSplitter/add_expense_splitter_model.dart';
import 'package:nivaas/data/repository-impl/expenseSplitter/add_expense_splitter_repositoryimpl.dart';

class AddExpenseSplitterUsecase {
  final AddExpenseSplitterRepositoryimpl repository;

  AddExpenseSplitterUsecase({required this.repository});

  Future<bool> call (AddExpenseSplitterModel splitDetails,){
      return repository.createExpenseSplitter(splitDetails);
    }
}