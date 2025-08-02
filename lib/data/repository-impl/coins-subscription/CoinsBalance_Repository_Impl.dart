import 'package:nivaas/data/provider/network/api/coins-subscription/CoinsBalance_DataSource.dart';
import 'package:nivaas/domain/repositories/coins-subscription/CoinsBalance_Repository.dart';

class CoinsBalanceRepositoryImpl implements CoinsBalanceRepository {
  final CoinsBalanceDataSource dataSource;

  CoinsBalanceRepositoryImpl({required this.dataSource});

  @override
  Future<double> getCoinsBalance({required int apartmentId}) {
    return dataSource.fetchCoinsBalance(apartmentId: apartmentId);
  }
}
