import 'package:nivaas/data/provider/network/api/maintainance/delete_debit_history_dataSource.dart';
import 'package:nivaas/domain/repositories/maintainance/delete_debit_history_repository.dart';

class DeleteDebitHistoryRepositoryImpl implements DeleteDebitHistoryRepository {
  final DeleteDebitHistoryDataSource dataSource;

  DeleteDebitHistoryRepositoryImpl({required this.dataSource});

  @override
  Future<void> deleteDebitHistory(int apartmentId, int itemId) async {
    return await dataSource.deleteDebitHistory(apartmentId, itemId);
  }
}
