import 'package:nivaas/data/models/coins-subscription/walletTransaction_model.dart';

abstract class CoinsWalletRepository {
  Future<List<Content>> fetchWalletTransactions({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  });
}
