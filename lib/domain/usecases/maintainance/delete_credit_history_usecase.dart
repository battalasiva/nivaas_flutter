import 'package:nivaas/domain/repositories/maintainance/delete_credit_history_repository.dart';

class DeleteCreditHistoryUseCase {
  final DeleteCreditHistoryRepository repository;

  DeleteCreditHistoryUseCase({required this.repository});

  Future<void> execute(int apartmentId, int itemId) async {
    return await repository.deleteCreditHistory(apartmentId, itemId);
  }
}
