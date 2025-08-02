import 'package:nivaas/domain/repositories/expenseSplitter/edit_Splitter_Details_Repository.dart';

class EditSplitterDetailsUseCase {
  final EditSplitterDetailsRepository repository;

  EditSplitterDetailsUseCase(this.repository);

  Future<void> call(int id, Map<String, dynamic> payload) {
    return repository.editSplitterDetails(id, payload);
  }
}
