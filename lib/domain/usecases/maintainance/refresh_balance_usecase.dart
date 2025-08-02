import 'package:nivaas/domain/repositories/maintainance/refresh_balance_repository.dart';

class RefreshBalanceUseCase {
  final RefreshBalanceRepository repository;

  RefreshBalanceUseCase(this.repository);

  Future<String> execute(int apartmentId) async {
    return await repository.refreshBalance(apartmentId);
  }
}
