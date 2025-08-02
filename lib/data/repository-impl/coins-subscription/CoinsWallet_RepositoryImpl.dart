import 'package:nivaas/data/models/coins-subscription/walletTransaction_model.dart';
import 'package:nivaas/data/provider/network/api/coins-subscription/CoinsWallet_DataSource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/CoinsWallet_Repository.dart';

class CoinsWalletRepositoryImpl implements CoinsWalletRepository {
  final CoinsWalletDataSource dataSource;

  CoinsWalletRepositoryImpl({required this.dataSource});

  @override
  Future<List<Content>> fetchWalletTransactions({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) async {
    final response = await dataSource.getWalletTransactions(
      apartmentId: apartmentId,
      pageNo: pageNo,
      pageSize: pageSize,
    );
    return response.content?.map((e) => e as Content).toList() ?? [];
  }
}
