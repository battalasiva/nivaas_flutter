import 'package:nivaas/data/models/Maintainance/current_balance_Modal.dart';
import 'package:nivaas/data/provider/network/api/maintainance/current_balance_dataSource.dart';
import 'package:nivaas/domain/repositories/maintainance/current_balance_repository.dart';

class CurrentBalanceRepositoryImpl implements CurrentBalanceRepository {
  final CurrentBalanceDataSource dataSource;

  CurrentBalanceRepositoryImpl({required this.dataSource});

  @override
  Future<CurrentBalanceModal> getCurrentBalance(int apartmentId) async {
    return await dataSource.fetchCurrentBalance(apartmentId);
  }
}
