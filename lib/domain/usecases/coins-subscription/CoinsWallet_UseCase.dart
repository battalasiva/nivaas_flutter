import 'package:nivaas/data/models/coins-subscription/walletTransaction_model.dart';
import 'package:nivaas/domain/repositories/coins-subscription/CoinsWallet_Repository.dart';

class CoinsWalletUseCase {
  final CoinsWalletRepository repository;

  CoinsWalletUseCase(this.repository);

  Future<List<Content>> getWalletTransactions({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) {
    return repository.fetchWalletTransactions(
      apartmentId: apartmentId,
      pageNo: pageNo,
      pageSize: pageSize,
    );
  }
}
