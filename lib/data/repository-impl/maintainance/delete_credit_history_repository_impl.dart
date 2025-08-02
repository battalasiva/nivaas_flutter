import 'package:nivaas/data/provider/network/api/maintainance/delete_credit_history_datasource.dart';
import 'package:nivaas/domain/repositories/maintainance/delete_credit_history_repository.dart';

class DeleteCreditHistoryRepositoryImpl
    implements DeleteCreditHistoryRepository {
  final DeleteCreditHistoryDataSource dataSource;

  DeleteCreditHistoryRepositoryImpl({required this.dataSource});

  @override
  Future<void> deleteCreditHistory(int apartmentId, int itemId) async {
    return await dataSource.deleteCreditHistory(apartmentId, itemId);
  }
}
