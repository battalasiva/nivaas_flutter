import 'package:nivaas/domain/repositories/coins-subscription/CoinsBalance_Repository.dart';

class GetCoinsBalanceUseCase {
  final CoinsBalanceRepository repository;

  GetCoinsBalanceUseCase(this.repository);

  Future<double> call({required int apartmentId}) {
    return repository.getCoinsBalance(apartmentId: apartmentId);
  }
}
