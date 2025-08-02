import 'package:nivaas/data/models/Maintainance/current_balance_Modal.dart';
import 'package:nivaas/domain/repositories/maintainance/current_balance_repository.dart';

class GetCurrentBalanceUseCase {
  final CurrentBalanceRepository repository;

  GetCurrentBalanceUseCase(this.repository);

  Future<CurrentBalanceModal> execute(int apartmentId) {
    return repository.getCurrentBalance(apartmentId);
  }
}
