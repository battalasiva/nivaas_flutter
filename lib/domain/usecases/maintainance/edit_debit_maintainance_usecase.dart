import 'package:nivaas/domain/repositories/maintainance/edit_debit_maintainance_repository.dart';

class EditDebitMaintainanceUseCase {
  final EditDebitMaintainanceRepository repository;

  EditDebitMaintainanceUseCase({required this.repository});

  Future<void> execute(int itemId, Map<String, dynamic> payload) {
    return repository.editDebitMaintainance(itemId, payload);
  }
}
