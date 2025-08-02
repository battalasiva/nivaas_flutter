import 'package:nivaas/data/provider/network/api/maintainance/refresh_balance_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/refresh_balance_repository.dart';

class RefreshBalanceRepositoryImpl implements RefreshBalanceRepository {
  final RefreshBalanceDataSource dataSource;

  RefreshBalanceRepositoryImpl(this.dataSource);

  @override
  Future<String> refreshBalance(int apartmentId) async {
    return await dataSource.refreshBalance(apartmentId);
  }
}
