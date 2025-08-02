import 'package:nivaas/domain/repositories/maintainance/delete_debit_history_repository.dart';

class DeleteDebitHistoryUseCase {
  final DeleteDebitHistoryRepository repository;

  DeleteDebitHistoryUseCase({required this.repository});

  Future<void> execute(int apartmentId, int itemId) async {
    return await repository.deleteDebitHistory(apartmentId, itemId);
  }
}
