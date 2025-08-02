import 'package:nivaas/domain/repositories/maintainance/edit_credit_maintainance_repository.dart';

class EditCreditMaintainanceUseCase {
  final EditCreditMaintainanceRepository repository;

  EditCreditMaintainanceUseCase({required this.repository});

  Future<void> execute(int itemId, Map<String, dynamic> payload) {
    return repository.editCreditMaintainance(itemId, payload);
  }
}
